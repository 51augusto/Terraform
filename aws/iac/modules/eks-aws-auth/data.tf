data "aws_iam_roles" "sso_admins" {
  for_each    = toset(local.k8s_sso_admins)
  name_regex  = "AWSReservedSSO_${each.key}_"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

##############################################################
#                       NÃO MEXER
##############################################################
data "aws_iam_roles" "break_glass" {
  name_regex = "role-eks-internal-${var.environment}-use1-break-glass"
}
##############################################################

data "aws_iam_roles" "app_ro" {
  for_each    = toset(var.app_names_for_k8s_users)
  name_regex  = "AWSReservedSSO_${upper(each.key)}_RO_"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_iam_roles" "app_editor" {
  for_each    = toset(var.app_names_for_k8s_users)
  name_regex  = "AWSReservedSSO_${upper(each.key)}_EDITOR_"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}

data "aws_iam_roles" "cicd" {
  for_each    = toset(var.app_names_for_k8s_cicd)
  name_regex  = "role-cicd-${lower(each.key)}-${var.environment}-${local.region_code}"
  path_prefix = "/"
}

data "aws_iam_role" "cicd_iac" {
  name = "role-cicd-${var.environment}-${local.region_code}-iac"
}

data "aws_iam_roles" "ops" {
  for_each    = toset(var.app_names_for_k8s_ops)
  name_regex  = "role-ops-${lower(each.key)}-${var.environment}-${local.region_code}"
  path_prefix = "/"
}

data "aws_iam_roles" "extra_sso_auths" {
  for_each    = toset(local.extra_sso_auths_for_each)
  name_regex  = "AWSReservedSSO_${upper(each.key)}_"
  path_prefix = "/aws-reserved/sso.amazonaws.com/"
}
