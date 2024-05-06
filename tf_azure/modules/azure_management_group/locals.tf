locals {
  all_level3_groups = merge([for l2_key, l2 in var.child_groups : {
    for l3_key, l3_value in l2 : l3_key => { parent_key = l2_key, children = l3_value }
  }]...)

  all_level4_groups = merge([for l3_key, l3_value in local.all_level3_groups : {
    for l4_key, l4_value in l3_value.children : l4_key => { parent_key = l3_key, children = l4_value }
  }]...)

  all_level5_groups = merge([for l4_key, l4_value in local.all_level4_groups : {
    for l5_key, l5_value in l4_value.children : l5_key => { parent_key = l4_key, children = l5_value }
  }]...)

  all_level6_groups = merge([for l5_key, l5_value in local.all_level5_groups : {
    for l6_key, l6_value in l5_value.children : l6_key => { parent_key = l5_key }
  }]...)
}
