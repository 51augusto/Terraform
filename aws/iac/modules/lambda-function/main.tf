resource "aws_lambda_function" "lambda_function" {
  function_name = local.function_name
  description   = local.description
  role          = aws_iam_role.role.arn
  architectures = var.architectures
  layers        = var.layers
  runtime       = var.runtime != "docker" ? var.runtime : null
  image_uri     = var.image_uri
  filename      = local.runtimes[var.runtime].filename
  handler       = local.runtimes[var.runtime].handler
  package_type  = var.runtime != "docker" ? "Zip" : "Image"
  publish       = false

  dynamic "vpc_config" {
    for_each = var.vpc_config != null ? [1] : []
    content {
      subnet_ids         = var.vpc_config.subnet_ids
      security_group_ids = local.security_group_ids
    }
  }

  dynamic "file_system_config" {
    for_each = var.file_system_config != null ? [1] : []
    content {
      arn              = var.file_system_config.arn
      local_mount_path = var.file_system_config.local_mount_path
    }
  }

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_config != null ? [1] : []
    content {
      target_arn = var.dead_letter_config.target_arn
    }
  }

  dynamic "tracing_config" {
    for_each = var.tracing_config != null ? [1] : []
    content {
      mode = var.tracing_config.mode
    }
  }

  lifecycle {
    # Atributos que podem ser alterados via Pipeline
    ignore_changes = [handler, timeout, memory_size, environment, layers, image_uri]
  }

  tags = {
    Name = local.function_name
  }

  depends_on = [aws_cloudwatch_log_group.log_group]
}

## TODOs
# Incluir possibilidade de criação parametrizada dos seguintes recursos:
# - aws_lambda_function_event_invoke_config
# - aws_lambda_provisioned_concurrency_config

resource "aws_cloudwatch_log_group" "log_group" {
  name              = local.log_group_name
  retention_in_days = var.logging_retention
  tags = {
    Name = local.log_group_name
  }
}