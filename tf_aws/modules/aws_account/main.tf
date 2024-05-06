resource "aws_organizations_account" "this" {
  close_on_deletion = true
  create_govcloud   = var.create_govcloud
  email             = var.email_address
  name              = var.name
  parent_id         = var.parent_ou_id
  role_name         = var.admin_role_name
  tags              = local.tags

  lifecycle {
    # There is no API to read role_name so it's recommended to ignore. Changes to
    # email/name require recreation. Ignoring these makes the plan for a new Gov child
    # account a little better. Without ignoring, Terragrunt will use a mock output for
    # the Gov account ID when it plans the import of the Gov child and will show that
    # the account needs to be recreated. I don't think we'll ever attept to change
    # email/name anyways since it would require account recreation so this should
    # be safe...
    ignore_changes = [email, name, role_name]
  }
}

resource "aws_account_alternate_contact" "common" {
  for_each = var.parent_ou_id == null ? {} : var.common_alternate_contacts

  account_id             = aws_organizations_account.this.id
  alternate_contact_type = each.value.alternate_contact_type
  email_address          = each.value.email_address
  name                   = each.key
  phone_number           = each.value.phone_number
  title                  = each.value.title
}

resource "aws_account_alternate_contact" "additional" {
  for_each = var.parent_ou_id == null ? {} : var.additional_alternate_contacts

  account_id             = aws_organizations_account.this.id
  alternate_contact_type = each.value.alternate_contact_type
  email_address          = each.value.email_address
  name                   = each.key
  phone_number           = each.value.phone_number
  title                  = each.value.title
}

resource "aws_ssoadmin_account_assignment" "common" {
  for_each = var.parent_ou_id == null ? try({ "ADMIN-Role" = var.common_sso_assignments["ADMIN-Role"] }, {}) : var.common_sso_assignments

  instance_arn       = each.value.instance_arn
  permission_set_arn = each.value.permission_set_arn
  principal_id       = each.value.principal_id
  principal_type     = each.value.principal_type
  target_id          = aws_organizations_account.this.id
  target_type        = each.value.target_type
}

resource "aws_ssoadmin_account_assignment" "additional" {
  for_each = var.parent_ou_id == null ? {} : var.additional_sso_assignments

  instance_arn       = each.value.instance_arn
  permission_set_arn = each.value.permission_set_arn
  principal_id       = each.value.principal_id
  principal_type     = each.value.principal_type
  target_id          = aws_organizations_account.this.id
  target_type        = each.value.target_type
}
