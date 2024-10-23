resource "aws_iam_role" "role" {
  count              = var.role == null ? 1 : 0
  name               = local.role_name
  description        = "Role da instancia EC2 ${local.instance_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = concat(
    local.aws_policies,
    local.custom_policies,
    var.policy_arns
  )
  tags = {
    Name = local.role_name
  }
}

resource "aws_iam_instance_profile" "profile" {
  name = local.profile_name
  role = var.role == null ? aws_iam_role.role[0].name : var.role
  tags = {
    Name = local.profile_name
  }
}