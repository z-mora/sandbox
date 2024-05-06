# tf_terragrunt

![Terraform Version](https://img.shields.io/badge/terraform-%3E%3D1.5.0-%235849a6.svg)
[![Terragrunt Version](https://img.shields.io/badge/terragrunt-%3E%3D0.48-blue.svg)](https://github.com/gruntwork-io/terragrunt)

<!-- markdownlint-disable no-inline-html -->
<img src="https://terragrunt.gruntwork.io/assets/img/home/t-o-2@3x.png" height="400" align="right">

Terragrunt is a thin wrapper for [Terraform](https://www.terraform.io/) that provides
extra tools for keeping your Terraform configurations
[DRY](https://en.wikipedia.org/wiki/Don%27t_repeat_yourself), working with multiple
Terraform modules, and managing remote state. It helps to prevent repetitive
information needed to make Terraform modules work.

This repo contains the variables used to define the resources to deploy to AWS and Azure.
It's used in conjunction with the
[tf_aws](https://bitbucket.parsons.com/projects/CM/repos/tf_aws) and
[tf_azure](https://bitbucket.parsons.com/projects/CM/repos/tf_azure) repos, which contain
the flexible and reusable Terraform codebases. It's also used with
[tf_aws_crowdstrike_falcon](https://bitbucket.parsons.com/projects/CM/repos/tf_aws_crowdstrike_falcon)
to deploy CrowdStrike Falcon to AWS organizations from the org management account.

See the following for documentation regarding Parsons' use and processes:

* [Terragrunt - What is it, Configuration, Folder Structure](https://confluence.parsons.com/display/IT/Terragrunt+-+What+is+it%2C+Configuration%2C+Folder+Structure)
* [Terraform - Jenkins Workflows](https://confluence.parsons.com/display/IT/Terraform+-+Jenkins+Workflows)

See the following for general documentation:

* [Getting started with Terragrunt](https://terragrunt.gruntwork.io/docs/getting-started/quick-start/)
* [Terragrunt Documentation](https://terragrunt.gruntwork.io/docs)

## Terragrunt Config Files

There are two main config files in this repo: `aws.hcl` and `azure.hcl`

These are shared by all of the deployments for the respective cloud provider.

## Terragrunt Modules

A Terragrunt module is a directory containing a `terragrunt.hcl` file. These working
directories have `.tfvars` files to define what resources to deploy. They also have
their own state file, which is stored remotely and managed by the config file.

## shared_data

This folder is used to store policies (or other items) that are referenced by multiple
Terragrunt modules in a central location. This allows you to define an object only once,
but still be able to reuse and deploy it to numerous locations.

`tfvars` are constants, so to use data in a central location such as this, you have to
use the [inputs block](https://terragrunt.gruntwork.io/docs/features/inputs/). For
example, to use the contents of a policy in this central location, you can add the
following to a Terragrunt module's `terragrunt.hcl` file:

```terragrunt
inputs = {
  iam_policies = {
    policy-terragrunt-admin = {
      description = "Policy Assume Role for Terragrunt Admin Plan and Apply"
      policy_yaml = file(
        "${get_repo_root()}/aws/shared_data/policies/terragrunt_admin.yaml"
      )
    }
  }
}
```

Similar to `tfvars`, this allows you to set the value of a Terraform variable. However,
an input gets passed to Terraform via environment variable and also allows dynamic
values.

Only YAML is supported at the moment. Once we upgrade to
[Terragrunt v0.52.5](https://github.com/gruntwork-io/terragrunt/releases/tag/v0.52.5)
or later we should be able to work with HCL in a central location by using the
[read_tfvars_file](https://terragrunt.gruntwork.io/docs/reference/built-in-functions/#read_tfvars_file)
function.

## Development Workflow

### Terraform Source

When working locally, the Terraform source will automatically be set to the common
local path. For example:

* `/code/cm/tf_aws` or `C:\dev\code\cm\tf_aws` depending on the OS
* `/code/cm/tf_azure` or `C:\dev\code\cm\tf_azure` depending on the OS

Make sure you've cloned these repos, have `main` checked out (unless you're working on
your own branch), and the branch is up to date.

### Authentication

You'll need to authenticate to the cloud provider you'll be using before getting started.

#### AWS

For AWS Commercial:

```sh
aws sso login --profile oce-ss
``````

For AWS GovCloud:

```sh
aws sso login --profile oce-ss
aws sso login --profile pce-ss
```

GovCloud deployments will need to authenticate to Commercial and GovCloud, because all
of the Route53 hosted zones are in a Commercial account.

#### Azure

With Azure, you have to switch the CLI between clouds. You can switch back and forth
without having to log in again, but they both can't be active/usable at the same time.

For Azure Commercial:

```sh
az cloud set --name AzureCloud
az login
```

For Azure Government:

```sh
az cloud set --name AzureUSGovernment
az login
```

#### Vault

You'll also need to authenticate to HashiCorp Vault, as both Terraform codebases use the
vault provider so secrets can be stored there. See [HashiCorp Vault - How to Login](
  https://confluence.parsons.com/display/IT/HashiCorp+Vault+-+How+to+Login
) for more info. To get a token you can log in to [hcvault.parsons.us](
  https://hcvault.parsons.us), click the user profile icon, and then Copy Token.

```sh
export VAULT_ADDR=https://hcvault.parsons.us
export VAULT_TOKEN=<token_value>
```

### CLI

Instead of calling terraform directly, you'll use `terragrunt` in all of your
commands. For example:

```sh
[vagrant@localhost oce-infraops-sandbox-12]$ pwd
/code/cm/tf_terragrunt/aws/comm-corp/it/oce-infraops-sandbox-12
[vagrant@localhost oce-infraops-sandbox-12]$ terragrunt plan
...
[vagrant@localhost oce-infraops-sandbox-12]$ terragrunt apply
...
```

### Process

1) Clone the repo to `C:\dev\code\cm\tf_terragrunt`
1) Checkout `main` and `git pull` to make sure it's up to date
1) Create a new branch named after your Jira story number, e.g., `git checkout -b STAR-1234`
1) Commit changes and push your branch
1) Open a PR
1) Ensure builds succeed and the planned changes are expected
1) Merge once approved

> NOTE: If your tf_terragrunt code relies on changes to tf_aws or tf_azure, you must
> merge your PR in those repos first or your tf_terragrunt builds will fail.
