<!-- BEGIN_TF_DOCS -->
# aws_iam_user

This module will allow you to deploy an IAM user, add it to groups (which have policies
applied), and create access keys. There are various options for creating and storing
access keys which are described in detail below.

## Creating Access Keys & Rotating Them

There are three methods of creating an access key which much be used exclusively of one
another. The Parsons password policy states that passwords cannot live longer than
180 days.

### auto_rotate_days

This will allow your access key to automatically rotate every x number of days. This is
best used for keys that are stored in HashiCorp Vault and used programmatically with no
user intervention required.

### staggered_rotation

This option will end up creating two access keys for you that have a staggered rotation
with overlap. This is best suited for keys that require user intervention when they need
to be rotated. The overlap will allow for no downtime.

### no rotation

This will allow you to create an access key that does not automatically rotate and does
not expire. This should not typically be used.

#### Architecture Notes

* Staggered rotation is achieved using the Time provider's resources `time_static` and
`time_rotating`. `time_offset` is not used because the timestamps need to be known
before apply. When you create a `time_offset` resource it doesn't calculate the values
until an apply is ran. Since we are using these time values within `for_each` (to
determine if something should exist), the values have to be known ahead of time or
Terraform will throw an error. We do the calculations ourselves using the `timeadd()`
function and store the result in a `time_static` resource.
* `plantimestamp()` is used instead of `timestamp`. This allows every resource within
a plan or apply operation to pull the same timestamp of the operation. Otherwise, each
one would differ by a few seconds.
* We have to ignore changes to some resource attributes, like `rfc3339`. If we don't
ignore these, every time you run a plan it will attempt to recreate the resource since
the value of `plantimestamp()` has changed. As a result, the value of a resource
attribute like `rfc3339` will only change when the resource is recreated.

#### Simplified Workflow

Here is a somewhat simplified workflow of what the resources look like for a single
access key:

* `time_rotating` resource to handle the rotation/cycle of the key every x number of days
* `time_static` resource to handle when the key should be created
  * Has a trigger to recreate when `time_rotating` changes and starts a new cycle
* `time_static` resource to handle when the key should be deleted
  * Has a trigger to recreate when `time_rotating` changes and starts a new cycle
* `azuread_application_password`
  * Logic within `for_each` to only create the access key if:
  `creation timestamp`<=`current time`<`deletion timestamp`

#### Time Calculations

* resource "time_static" "first_run_timestamp"
  * timestamp = plantimestamp()

##### Key One

* resource "time_rotating" "staggered_key_one"
  * timestamp (first run) = plantimestamp() - overlap days
    * Start first rotation in the past so the two rotations are staggered
  * timestamp (remaining runs) = plantimestamp()
  * rotation_days = rotate_days * 2
* resource "time_static" "staggered_key_one_creation"
  * Same timestamp as time_rotating.staggered_key_one
* resource "time_static" "staggered_key_one_deletion"
  * time_rotating.staggered_key_one + rotate_days + overlap_days

##### Key Two

* resource "time_rotating" "staggered_key_two"
  * timestamp = plantimestamp()
  * rotation_days = rotate_days * 2
* resource "time_static" "staggered_key_two_creation"
  * time_rotating.staggered_key_two + rotate_days - overlap_days
* resource "time_static" "staggered_key_two_deletion"
  * time_rotating.staggered_key_two + rotate_days * 2

#### Example Rotation

In this example, rotate_days = 10 and overlap_days = 2

| Day | Key One | Key Two | Note                               |
| ----| ---------- | ---------- | ---------------------------------- |
| -2  |            |            | New rotation for Key One starts |
| 0   | Created    |            | New rotation for Key Two starts |
| 8   |            | Created    |                                    |
| 10  | Deleted    |            |                                    |
| 18  | Created    |            | New rotation for Key One starts |
| 20  |            | Deleted    | New rotation for Key Two starts |
| 28  |            | Created    |                                    |
| 30  | Deleted    |            |                                    |
| 38  | Created    |            | New rotation for Key One starts |
| 40  |            | Deleted    | New rotation for Key Two starts |
| 48  |            | Created    |                                    |
| 50  | Deleted    |            |                                    |

## Storing Access Keys in Vault

This module implements the best practices outlined in
[HashiCorp Vault - Secrets Best Practices and Standards](
  https://confluence.parsons.com/display/IT/HashiCorp+Vault+-+Secrets+Best+Practices+and+Standards
) for creating secret paths and storing values. The provided Vault path will automatically
have two subfolders created within it:

* access_key_id
* secret_access_key

Within each of these paths, a key value pair is used to store the secret value and
`value` is used as the key name.

For example, if you provide a mount of `kv2_opde_it_devs`
and a path of `team_cloud/aws/comm/_sys_terragrunt_admin`, the following will be created:

* kv2_opde_it_devs/team_cloud/aws/comm/_sys_terragrunt_admin/access_key_id
  * `{ value = <access_key_id_here> }`
* kv2_opde_it_devs/team_cloud/aws/comm/_sys_terragrunt_admin/secret_access_key
  * `{ value = <secret_access_key_here> }`

To retrieve a secret when it's stored in this manner you can specify the path and the
field/key name so it will return the value instead of the JSON object. For example:

```sh
vagrant@localhost(/home/vagrant) $ vault kv get -field=value kv2_opde_it_devs/team_cloud/aws/comm/_sys_terragrunt_admin/access_key_id
ASDFQWERTY123456789
```

> NOTE: The `vault_kv_secret_v2` resources are configured so that when they're destroyed
> they'll purge all versions of the secret so clutter isn't left behind

### Storing Staggered Access Keys

The usage of Vault will be the same for staggered access keys, except they will be
separated into subfolders to differentiate between key one and key two. For example,
if you define an access key called `jenkins` for `_sys_test_user` with staggered
rotation, the 2 Vault secrets above would each get placed into a subfolder:

`kv2_opde_it_devs/team_cloud/aws/comm/_sys_test_user/jenkins-one/`

or

`kv2_opde_it_devs/team_cloud/aws/comm/_sys_test_user/jenkins-two/`

## Provider Requirements

This module expects two providers:

* A default AWS provider which is assuming a role in the current account
* A default vault provider to support storing access keys in HashiCorp Vault. The
credentials used to configure the provider must have access to the mounts & paths
specified in `var.access_keys`

## Additional Info

* [aws_iam_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user)
* [aws_iam_user_group_membership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership)
* [aws_iam_access_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key)
* [vault_kv_secret_v2](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_keys"></a> [access\_keys](#input\_access\_keys) | A collection of IAM access keys to create. The value for `auto_rotate_days` must not<br>be greater than 180 to be compliant with Parsons' security policies. If you choose to<br>store an access key in vault, any existing key at that path will be overwritten. | <pre>map(object({<br>    auto_rotate_days = optional(number)<br>    staggered_rotation = optional(object({<br>      overlap_days = optional(number, 10)<br>      rotate_days  = number<br>    }))<br>    status = optional(string, "Active")<br>    vault = optional(object({<br>      mount = string<br>      path  = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_groups"></a> [groups](#input\_groups) | A map of groups to add the user to. The key is the key of the group and the<br>value is the group name. | `map(string)` | `{}` | no |
| <a name="input_name"></a> [name](#input\_name) | The user's name. The name must consist of upper and lowercase alphanumeric characters<br>with no spaces. You can also include any of the following characters: =,.@-\_.. User<br>names are not distinguished by case. For example, you cannot create users named both<br>"TESTUSER" and "testuser". | `string` | n/a | yes |
| <a name="input_path"></a> [path](#input\_path) | Path in which to create the user. | `string` | `"/"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Optional tags to override provider defaults | <pre>object({<br>    App         = optional(string)<br>    Environment = optional(string)<br>    GBU         = optional(string)<br>    ITSM        = optional(string, "MANAGEMENT")<br>    JobWbs      = optional(string)<br>    Notes       = optional(string)<br>    Owner       = optional(string)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_access_keys"></a> [access\_keys](#output\_access\_keys) | The IAM access keys for the user |
| <a name="output_arn"></a> [arn](#output\_arn) | The ARN of the user that was created |

## Resources

| Name | Type |
|------|------|
| [aws_iam_access_key.auto_rotate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.no_auto_rotate](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.staggered_key_one](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_access_key.staggered_key_two](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_access_key) | resource |
| [aws_iam_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user) | resource |
| [aws_iam_user_group_membership.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_user_group_membership) | resource |
| [time_rotating.staggered_key_one](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_rotating.staggered_key_two](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_rotating.this](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/rotating) | resource |
| [time_static.first_run_timestamp](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.staggered_key_one_creation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.staggered_key_one_deletion](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.staggered_key_two_creation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.staggered_key_two_deletion](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [time_static.this](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [vault_kv_secret_v2.access_key_id](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_kv_secret_v2.secret_access_key](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_kv_secret_v2.staggered_key_one_access_key_id](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_kv_secret_v2.staggered_key_one_secret_access_key](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_kv_secret_v2.staggered_key_two_access_key_id](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |
| [vault_kv_secret_v2.staggered_key_two_secret_access_key](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2) | resource |

## Examples

```hcl
# Example 1 - Uer with no access keys
iam_users = {
  _sys_test_user = {
    group_keys = ["group-test"]
  }
}

# Example 2 - User with an access key
iam_users = {
  _sys_test_user = {
    access_keys = {
      test = {}
    }
    group_keys = ["group-test"]
  }
}

# Example 3 - User with an access key stored in HC Vault
iam_users = {
  _sys_test_user = {
    access_keys = {
      test = {
        vault = {
          mount = "kv2_opde_it_devs"
          path = "team_cloud/aws/comm/_sys_test_user"
        }
      }
    }
    group_keys = ["group-test"]
  }
}

# Example 4 - User with an auto-rotated access key stored in HC Vault
iam_users = {
  _sys_test_user = {
    access_keys = {
      test = {
        auto_rotate_days = 90
        vault = {
          mount = "kv2_opde_it_devs"
          path = "team_cloud/aws/comm/_sys_test_user"
        }
      }
    }
    group_keys = ["group-test"]
  }
}

# Example 5 - User with a staggered rotation access key stored in HC Vault
iam_users = {
  _sys_test_user = {
    access_keys = {
      jenkins = {
        staggered_rotation = {
          overlap_days = 3
          rotate_days = 10
        }
        vault = {
          mount = "kv2_opde_it_devs"
          path  = "team_cloud/aws/comm/_sys_test_user"
        }
      }
    }
    group_keys = ["group-test-user"]
  }
}
```
<!-- END_TF_DOCS -->