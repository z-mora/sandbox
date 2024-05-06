resource "azurerm_management_group" "level_1" {
  name = var.name
}

resource "azurerm_management_group" "level_2" {
  for_each = var.child_groups

  name                       = each.key
  parent_management_group_id = azurerm_management_group.level_1.id
}

resource "azurerm_management_group" "level_3" {
  for_each = local.all_level3_groups

  name                       = each.key
  parent_management_group_id = azurerm_management_group.level_2[each.value.parent_key].id
}

resource "azurerm_management_group" "level_4" {
  for_each = local.all_level4_groups

  name                       = each.key
  parent_management_group_id = azurerm_management_group.level_3[each.value.parent_key].id
}

resource "azurerm_management_group" "level_5" {
  for_each = local.all_level5_groups

  name                       = each.key
  parent_management_group_id = azurerm_management_group.level_4[each.value.parent_key].id
}

resource "azurerm_management_group" "level_6" {
  for_each = local.all_level6_groups

  name                       = each.key
  parent_management_group_id = azurerm_management_group.level_5[each.value.parent_key].id
}
