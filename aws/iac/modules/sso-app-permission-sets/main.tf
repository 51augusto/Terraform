##############################################
# SSO Permissions Sets
##############################################

resource "aws_ssoadmin_permission_set" "ro" {
  for_each = var.sso_applications

  name             = "${upper(each.key)}_RO"
  description      = "Acesso somente leitura nos ambientes da aplicacao ${each.value.application_tag_values[0]}."
  instance_arn     = local.instance_arn
  session_duration = "PT1H"

  tags = {
    Name = "${upper(each.key)}_RO"
  }
}

resource "aws_ssoadmin_permission_set" "editor" {
  for_each = var.sso_applications

  name             = "${upper(each.key)}_EDITOR"
  description      = "Acesso de escrita nos ambientes da aplicacao ${each.value.application_tag_values[0]}."
  instance_arn     = local.instance_arn
  session_duration = "PT1H"

  tags = {
    Name = "${upper(each.key)}_EDITOR"
  }
}

##############################################
# SSO Permissions Sets - Inline Policy
##############################################

resource "aws_ssoadmin_permission_set_inline_policy" "editor" {
  for_each = var.sso_applications

  inline_policy      = data.aws_iam_policy_document.editor[each.key].json
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
}

resource "aws_ssoadmin_permission_set_inline_policy" "ro" {
  for_each = var.sso_applications

  inline_policy      = data.aws_iam_policy_document.ro[each.key].json
  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.ro[each.key].arn
}

####################################################
# SSO Permissions Sets - Managed Policy Attachment
####################################################

resource "aws_ssoadmin_managed_policy_attachment" "ro" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.ro[each.key].arn
}

resource "aws_ssoadmin_managed_policy_attachment" "editor" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  managed_policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
}

#####################################################################
# Associação Grupo + Permission Sets nas contas - Grupo RO
#####################################################################

resource "aws_ssoadmin_account_assignment" "ro_dev" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.ro[each.key].arn
  principal_id       = data.aws_identitystore_group.ro[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-dev"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "ro_cer" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.ro[each.key].arn
  principal_id       = data.aws_identitystore_group.ro[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-cer"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "ro_hml" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.ro[each.key].arn
  principal_id       = data.aws_identitystore_group.ro[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-hml"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "ro_prd" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.ro[each.key].arn
  principal_id       = data.aws_identitystore_group.ro[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-prd"]
  target_type        = "AWS_ACCOUNT"
}

#####################################################################
# Associação Grupo + Permission Sets nas contas - Grupo DEV
#####################################################################

resource "aws_ssoadmin_account_assignment" "dev_dev" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
  principal_id       = data.aws_identitystore_group.dev[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-dev"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "dev_cer" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
  principal_id       = data.aws_identitystore_group.dev[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-cer"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "dev_hml" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
  principal_id       = data.aws_identitystore_group.dev[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-hml"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "dev_prd" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.ro[each.key].arn
  principal_id       = data.aws_identitystore_group.dev[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-prd"]
  target_type        = "AWS_ACCOUNT"
}

#####################################################################
# Associação Grupo + Permission Sets nas contas - Grupo OWNER
#####################################################################

resource "aws_ssoadmin_account_assignment" "owner_dev" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
  principal_id       = data.aws_identitystore_group.owner[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-dev"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "owner_cer" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
  principal_id       = data.aws_identitystore_group.owner[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-cer"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "owner_hml" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
  principal_id       = data.aws_identitystore_group.owner[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-hml"]
  target_type        = "AWS_ACCOUNT"
}

resource "aws_ssoadmin_account_assignment" "owner_prd" {
  for_each = var.sso_applications

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.editor[each.key].arn
  principal_id       = data.aws_identitystore_group.owner[each.key].group_id
  principal_type     = "GROUP"
  target_id          = local.account_ids["workload-prd"]
  target_type        = "AWS_ACCOUNT"
}