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
