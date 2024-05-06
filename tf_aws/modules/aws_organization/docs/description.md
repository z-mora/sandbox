# aws_organization

This module allows the creation of an AWS organization and management of organization policies and OUs.

## Provider Requirements

This module requires one provider:

1) A default provider which is assuming a role in the org master account where the organization is managed

## Organization Policy Map

The policy map contains each policy as a separate object. Each policy must contain a description of the policy
and a content string. The content string should be a multi-line string containing the json formatted policy rule.

Note: AWS managed policies cannot be managed by Terraform. They use a different form of ID (simply the policy name),
and when used terraform throws an invalid ID error.

## OU map

Since OUs can be nested within each other, that nested configuration must be reconsituted here. Each OU name should
be a key to its own map nested under its parent ou. The Root OU is not managed itself, but its policies are, so it should always
be represented in this map as the highest tier and have the key "Root".

If an OU has policies attached to it they are assigned by a list of strings called policies. Each string should match
a policy listed in the policies map within the organization map. This assigns the matching policy to the OU.
