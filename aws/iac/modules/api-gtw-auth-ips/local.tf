locals {
  authorizer_name    = "api-auth-${module.this.custom_context_id}-${var.name}"
  function_name      = "lambda-${module.this.custom_context_id}-${var.name}"
  auth_role_name     = "role-${local.authorizer_name}"
  lambda_role_name   = "role-${local.function_name}"
  auth_policy_name   = "policy-${local.authorizer_name}"
  lambda_policy_name = "policy-${local.function_name}"
  log_group_name     = "/aws/lambda/${local.function_name}"
}