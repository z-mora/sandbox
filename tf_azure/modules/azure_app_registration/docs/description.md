# azure_app_registration

This module allows you to create an Azure AD app registration with API permissions, a
service principal, client secrets, and client certificates. There are various options
for creating and storing client secrets which are described in detail below.

that are created can be
automatically rotated every x number of days and stored in HashiCorp Vault.

Things to note:

* Owners are currently ignored because we may not need to set them once we are
Application Administrators
* Existing secrets can't be imported
* App registrations don't support tagging
* Since this module was created, additional resources were added to the azuread provider
that allow managing difference pieces of an app registration separately.

## Creating Secrets & Rotating Them

There are three methods of creating a secret which much be used exclusively of one
another. The Parsons password policy states that passwords cannot live longer than
180 days.

### auto_rotate_days

This will allow your secret to automatically rotate every x number of days. This is best
used for secrets that are stored in HashiCorp Vault and used programmatically with no
user intervention required.

### end_date_relative

This will allow you to create a secret which has an end date that is relative to its
creation date. See the [docs](
  https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password#end_date_relative
) for examples. I believe you must specify the value in hours, minutes or both. For
example:
`240h`, `1000m`, or `2400h30m`

### staggered_rotation

This option will end up creating two secrets for you that have a staggered rotation with
overlap. This is best suited for secrets that require user intervention when they need
to be rotated. The overlap will allow for no downtime.

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
secret:

* `time_rotating` resource to handle the rotation/cycle of the secret every x number of days
* `time_static` resource to handle when the secret should be created
  * Has a trigger to recreate when `time_rotating` changes and starts a new cycle
* `time_static` resource to handle when the secret should be deleted
  * Has a trigger to recreate when `time_rotating` changes and starts a new cycle
* `azuread_application_password`
  * Logic within `for_each` to only create the secret if:
  `creation timestamp`<=`current time`<`deletion timestamp`

#### Time Calculations

* resource "time_static" "first_run_timestamp"
  * timestamp = plantimestamp()

##### Secret One

* resource "time_rotating" "staggered_secret_one"
  * timestamp (first run) = plantimestamp() - overlap days
    * Start first rotation in the past so the two rotations are staggered
  * timestamp (remaining runs) = plantimestamp()
  * rotation_days = rotate_days * 2
* resource "time_static" "staggered_secret_one_creation"
  * Same timestamp as time_rotating.staggered_secret_one
* resource "time_static" "staggered_secret_one_deletion"
  * time_rotating.staggered_secret_one + rotate_days + overlap_days

##### Secret Two

* resource "time_rotating" "staggered_secret_two"
  * timestamp = plantimestamp()
  * rotation_days = rotate_days * 2
* resource "time_static" "staggered_secret_two_creation"
  * time_rotating.staggered_secret_two + rotate_days - overlap_days
* resource "time_static" "staggered_secret_two_deletion"
  * time_rotating.staggered_secret_two + rotate_days * 2

#### Example Rotation

In this example, rotate_days = 10 and overlap_days = 2

| Day | Secret One | Secret Two | Note                               |
| ----| ---------- | ---------- | ---------------------------------- |
| -2  |            |            | New rotation for Secret One starts |
| 0   | Created    |            | New rotation for Secret Two starts |
| 8   |            | Created    |                                    |
| 10  | Deleted    |            |                                    |
| 18  | Created    |            | New rotation for Secret One starts |
| 20  |            | Deleted    | New rotation for Secret Two starts |
| 28  |            | Created    |                                    |
| 30  | Deleted    |            |                                    |
| 38  | Created    |            | New rotation for Secret One starts |
| 40  |            | Deleted    | New rotation for Secret Two starts |
| 48  |            | Created    |                                    |
| 50  | Deleted    |            |                                    |

## Storing Secrets in Vault

This module implements the best practices outlined in
[HashiCorp Vault - Secrets Best Practices and Standards](
  https://confluence.parsons.com/display/IT/HashiCorp+Vault+-+Secrets+Best+Practices+and+Standards
) for creating secret paths and storing values. The provided Vault path will automatically
have three subfolders created within it:

* client_id
* client_secret
* tenant_id

Within each of these paths, a key value pair is used to store the secret value and
`value` is used as the key name.

For example, if you provide a mount of `kv2_opde_it_devs` and a path of
`team_cloud/azure/comm/_sys_terragrunt_admin`, the following will be created:

* kv2_opde_it_devs/team_cloud/azure/comm/_sys_terragrunt_admin/client_id
  * `{ value = <client_id_here> }`
* kv2_opde_it_devs/team_cloud/azure/comm/_sys_terragrunt_admin/client_secret
  * `{ value = <client_secret_here> }`
* kv2_opde_it_devs/team_cloud/azure/comm/_sys_terragrunt_admin/tenant_id
  * `{ value = <tenant_id_here> }`

To retrieve a secret when it's stored in this manner you can specify the path and the
field/key name so it will return the value instead of the JSON object. For example:

```sh
vagrant@localhost(/home/vagrant) $ vault kv get -field=value kv2_opde_it_devs/team_cloud/azure/comm/_sys_terragrunt_admin/client_id
ASDFQWERTY123456789
```

> NOTE: The `vault_kv_secret_v2` resources are configured so that when they're destroyed
> they'll purge all versions of the secret so clutter isn't left behind

### Storing Staggered Secrets

The usage of Vault will be the same for staggered secrets, except they will be separated
into subfolders to differentiate between secret one and secret two. For example, if you
define a secret called `jenkins` for `_sys_test_user` with staggered rotation, the 3
secrets above would each get placed into a subfolder:

`kv2_opde_it_devs/team_cloud/azure/comm/_sys_testuser/jenkins-one/`

or

`kv2_opde_it_devs/team_cloud/azure/comm/_sys_testuser/jenkins-two/`

## Provider Requirements

This module expects two providers:

* A default Azure AD provider
  * When authenticated with a service principal, this module requires you to have the
`Application.ReadWrite.All` API permission. When authenticated with a user principal,
this module requires you to have the `Application Administrator` or
`Global Administrator` role.
* A default vault provider to support storing client secrets in HashiCorp Vault. The
credentials used to configure the provider must have access to the mounts & paths
specified in `var.access_keys`

## Additional Info

* [Microsoft Graph permissions reference](https://learn.microsoft.com/en-us/graph/permissions-reference)
* [azuread_application](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application)
* [azuread_service_principal](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/service_principal)
* [azuread_application_password](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/resources/application_password)
* [vault_kv_secret_v2](https://registry.terraform.io/providers/hashicorp/vault/latest/docs/resources/kv_secret_v2)
* [Time Provider](https://registry.terraform.io/providers/hashicorp/time/latest/docs)
