resource "aws_apigatewayv2_api" "api" {
  name                         = local.api_name
  description                  = var.description
  protocol_type                = "HTTP"
  disable_execute_api_endpoint = var.disable_execute_api_endpoint

  dynamic "cors_configuration" {
    for_each = var.cors_configuration != null ? [1] : []
    content {
      allow_credentials = var.cors_configuration.allow_credentials
      allow_headers     = var.cors_configuration.allow_headers
      allow_methods     = var.cors_configuration.allow_methods
      allow_origins     = var.cors_configuration.allow_origins
      expose_headers    = var.cors_configuration.expose_headers
      max_age           = var.cors_configuration.max_age
    }
  }

  tags = {
    Name = local.api_name
  }
}

resource "aws_apigatewayv2_domain_name" "domain_name" {
  domain_name = var.domain_name

  domain_name_configuration {
    certificate_arn = var.certificate_arn
    endpoint_type   = "REGIONAL"
    security_policy = "TLS_1_2"
  }

  tags = {
    Name = local.domain_name
  }
}

resource "aws_apigatewayv2_stage" "stage" {
  api_id      = aws_apigatewayv2_api.api.id
  name        = "$default"
  auto_deploy = true

  dynamic "access_log_settings" {
    for_each = var.enable_access_log ? [1] : []
    content {
      destination_arn = aws_cloudwatch_log_group.log_group[0].arn
      format          = var.logging_format
    }
  }

  tags = {
    Name = local.api_stage_name
  }

  lifecycle {
    ignore_changes = [stage_variables]
  }
}

resource "aws_apigatewayv2_api_mapping" "api_mapping" {
  api_id      = aws_apigatewayv2_api.api.id
  domain_name = aws_apigatewayv2_domain_name.domain_name.id
  stage       = aws_apigatewayv2_stage.stage.id
}

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.enable_access_log ? 1 : 0
  name              = local.log_group_name
  retention_in_days = var.logging_retention
  tags = {
    Name = local.log_group_name
  }
}