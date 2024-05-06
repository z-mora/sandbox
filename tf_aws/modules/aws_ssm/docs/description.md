# aws_ssm

This module will build a standard Parsons SSM deployment for automated patch management
and SOC tools installation. For more information see
[this](https://confluence.parsons.com/pages/viewpage.action?pageId=246285338)
Confluence page.

The provider passed to the module will need to be assuming a role in the account
where you want SSM to be deployed.

These tags are set for all SSM resources in every account:

| Tag | Value |
|---|---|
| GBU | COR |
| ITSM | MANAGEMENT |
| Job/Wbs | 897720-01101 |
| Owner | infraopscloud@parsons.com |

You must ensure that you're not setting the same tag key/value as a default tag
and in the SSM module. If you do, Terraform will attempt to set the tag on every run
without making any changes. There's a local in the root module, `ssm_tags` that
addresses this for you by skipping any SSM tags that happen to be the same as a default
tag.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the account
that will be utilizing SSM.
