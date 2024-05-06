# tf_aws

<!-- markdownlint-disable no-inline-html -->
<img src="https://www.datocms-assets.com/2885/1620155113-brandhcterraformprimaryattributedcolor.svg" alt="Terraform logo" height="50" />
&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://d0.awsstatic.com/logos/powered-by-aws.png" alt="Powered by AWS" height="50">

![Terraform Version](https://img.shields.io/badge/Terraform-%3E=1.5.0-7B42BC)
![terraform-aws](https://img.shields.io/badge/terraform--provider--aws-~%3E_5.0-FF9900)

[Terraform](https://www.terraform.io/) is a tool for building, changing, and versioning
infrastructure safely and efficiently. This repo is used in conjunction
with Terraform's [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
and the [tf_terragrunt](https://bitbucket.parsons.com/projects/CM/repos/tf_terragrunt) repo.

This repo contains reusable Terraform modules, while the Terragrunt repo contains
the variables used to define the resources deployed to the different environments.

Please see the following for more info, including install instructions and complete documentation:

* [Terraform/Terragrunt Usage at Parsons](https://confluence.parsons.com/display/IT/Terragrunt)
* [Terraform Website](https://www.terraform.io)
* [Terraform Documentation](https://www.terraform.io/docs/)
* [Terraform Tutorials](https://learn.hashicorp.com/terraform)
* [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

## Development Workflow

See
[tf_terragrunt](https://bitbucket.parsons.com/projects/CM/repos/tf_terragrunt/browse)
for more info.

1) Clone the repo to `C:\dev\code\cm\tf_aws`
1) Checkout `main` and `git pull` to make sure it's up to date
1) Create a new branch named after your Jira story number, e.g., `git checkout -b STAR-1234`
1) Commit changes and push your branch
1) Open a PR, ensure builds succeed
1) Merge once approved

## Documentation & Examples

This repo uses [terraform-docs](https://terraform-docs.io/) to help with documentation
generation for every module. The config file, `.terraform-docs.yaml`, specifies the
format of the generated README. This tool also forces documentation to be created for
each module. It runs automatically against every PR by the `Jenkinsfile` and will add a
commit to the PR with any changes. Each module's variables (inputs), outputs, and
resources are automatically added to the README in tabular format.

Every module, including the root module, should contain a
`docs` folder, which must contain `description.md` and `examples.txt`. The file
`description.md` should at least contain a H1 heading with the module name and a brief
description of the module. Since we use Bitbucket, make sure you follow their
[Markdown syntax guide](https://confluence.atlassian.com/bitbucketserver/markdown-syntax-guide-776639995.html).
`examples.txt` should contain at least 1 example of a root
module variable value which would be passed to the module. Since these modules are not
standalone and are only used in this repo by the root module, the only examples
provided help you learn how to use the module in the context of this repo.

> NOTE: Do not edit any `README.md` file manually or your changes will get overwritten!

## Linting, Formatting, & Best Practices

This repo uses [tflint](https://github.com/terraform-linters/tflint) and the plugin
[tflint-ruleset-aws](https://github.com/terraform-linters/tflint-ruleset-aws) to find
possible errors, warn about deprecated syntax and unused declarations, and enforce
best practices. The `Jenkinsfile` in the root of this repo runs automatically against
every PR and will cause the PR's build to fail if there are any findings. Formatting is
handled by the Terraform CLI and any changes will be committed and pushed to the PR's
dev branch. We attempt to follow the best practices outlined in Google's
[Best practices for using Terraform](https://cloud.google.com/docs/terraform/best-practices-for-terraform).
