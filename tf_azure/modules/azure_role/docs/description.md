# azure_role

This module allows you to build a custom role with permissions (Actions, NotActions,
DataActions, and NotDataActions). We typically use this to provide the BU owners with
limited administrator access to their subscription. At this time, the role and users are
manually assigned to the subscription in the UI.

## Additional Info

* [What is Azure role-based access control (Azure RBAC)?](https://learn.microsoft.com/en-us/azure/role-based-access-control/overview)
* [azurerm_role_definition](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_definition.html)
