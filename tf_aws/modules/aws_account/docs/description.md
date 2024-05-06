# aws_account

This module will create a new account (either Commercial or GovCloud) with contacts and
SSO assignments.

The provider passed to the module will need to be assuming a role in the org master
where you want to create the account.

NOTE: Corporate accounts (except for network accounts) will always have their `Job/Wbs`
tag set to an empty string, per FinOps.

## GovCloud

`create_govcloud` can only be set to true when creating a new account, not afterwards.
You cannot create a GovCloud account on an account that already exists. If you create a
GovCloud account, you will end up with two accounts:

- A parent account in the Commercial partition where billing is handled
- A child account in the GovCloud partition which is linked to the parent. This is where
you will deploy resources

Unfortunately, when Terraform creates a GovCloud account it doesn't get added to the
state file or an organization. Only the Commerical parent will be in the state. You will
need an external process to import the GovCloud child account into the state file to
have it managed by Terraform and add it to an organization.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
organization's management account.
