locals {
  function_name    = "lambda-${module.this.custom_context_id}-${var.name}"
  description      = var.description != null ? var.description : "Função Lambda ${local.function_name}"
  role_name        = "role-${local.function_name}"
  logs_policy_name = "policy-${local.function_name}-logs"
  vpc_policy_name  = "policy-${local.function_name}-vpc"
  xray_policy_name = "policy-${local.function_name}-xray"
  cicd_policy_name = "policy-cicd-${local.function_name}"
  ops_policy_name  = "policy-ops-${local.function_name}"
  app_policy_name  = "policy-app-${local.function_name}"
  sg_name          = "SG-${local.function_name}"
  log_group_name   = "/aws/lambda/${local.function_name}"
  runtimes = {
    "java11" = {
      filename = "${path.module}/resources/java11.zip"
      handler  = "example.Hello::handleRequest"
    }
    "java17" = {
      filename = "${path.module}/resources/java17.zip"
      handler  = "example.Hello::handleRequest"
    }
    "python3.9" = {
      filename = "${path.module}/resources/python39.zip"
      handler  = "lambda_function.lambda_handler"
    }
    "python3.10" = {
      filename = "${path.module}/resources/python310.zip"
      handler  = "lambda_function.lambda_handler"
    }
    "python3.11" = {
      filename = "${path.module}/resources/python311.zip"
      handler  = "lambda_function.lambda_handler"
    }
    "nodejs14.x" = {
      filename = "${path.module}/resources/nodejs14.zip"
      handler  = "index.handler"
    }
    "docker" = {
      filename = null
      handler  = null
    }
  }
  create_sg = try(var.vpc_config.create_default_sg, false)
  security_group_ids = concat(
    try(var.vpc_config.security_group_ids, []),
    try([aws_security_group.sg[0].id], [])
  )
}
