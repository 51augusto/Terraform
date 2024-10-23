locals {
  function_name    = "lambda-edge-${module.this.custom_context_id}-${var.name}"
  description      = var.description != null ? var.description : "Função Lambda@Edge ${local.function_name}"
  log_group_name   = "/aws/lambda/us-east-1.${local.function_name}"
  role_name        = "role-${local.function_name}"
  logs_policy_name = "policy-${local.function_name}-logs"
  cicd_policy_name = "policy-cicd-${local.function_name}"
  runtimes = {
    "nodejs14.x" = {
      filename = "resources/nodejs14.zip"
      handler  = "index.handler"
    }
    "nodejs16.x" = {
      filename = "resources/nodejs16.zip"
      handler  = "index.handler"
    }
  }

}
