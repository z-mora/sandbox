# aws_iam_group

This module will allow you to deploy an IAM group with 1 or more policies attached.

We use groups to assign policies to users, even if it's just a single user in the group.

## Provider Requirements

This module expects a single, default provider which is assuming a role in the
current account.

## Additional Info

* [12 AWS IAM Security Best Practices - #2 Attach Permissions to Groups Instead of Individual Users](https://spacelift.io/blog/aws-iam-best-practices#2-attach-permissions-to-groups-instead-of-individual-users)
* [aws_iam_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group)
* [aws_iam_group_policy_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_group_policy_attachment)
