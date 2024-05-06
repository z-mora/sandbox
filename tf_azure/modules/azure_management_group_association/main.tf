resource "azurerm_management_group_subscription_association" "this" {
  management_group_id = data.azurerm_management_group.management_group.id
  subscription_id     = data.azurerm_subscription.subscription.id

  # Move subscription to new management group before trying to delete the old assocation,
  # otherwise it wll try to move the subscription to the root management group temporarily.
  # Moving to root first may cause errors, for example if there's a role assignment on the
  # subscription and the role doesn't exist at root.
  # Even using create_before_destroy will probably still fail when trying to delete the
  # original association, but at least it will move the sub for you.
  # See https://github.com/hashicorp/terraform-provider-azurerm/issues/21930
  lifecycle {
    create_before_destroy = true
  }
}
