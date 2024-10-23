resource "aws_apigatewayv2_authorizer" "authorizer" {
  name                              = local.authorizer_name
  api_id                            = var.api_id
  authorizer_type                   = "REQUEST"
  authorizer_uri                    = aws_lambda_function.lambda_function.invoke_arn
  authorizer_credentials_arn        = aws_iam_role.auth_role.arn
  identity_sources                  = ["$request.header.Authorization"]
  authorizer_payload_format_version = "2.0"
  enable_simple_responses           = true
  authorizer_result_ttl_in_seconds  = var.cache_ttl
}

resource "aws_lambda_function" "lambda_function" {
  function_name    = local.function_name
  description      = "Função Lambda ${local.function_name}"
  role             = aws_iam_role.lambda_role.arn
  architectures    = ["x86_64"]
  runtime          = "python3.11"
  filename         = data.archive_file.lambda_package.output_path
  source_code_hash = data.archive_file.lambda_package.output_base64sha256
  handler          = "lambda_function.lambda_handler"

  environment {
    variables = {
      USERNAME = "user"
      PASSWORD = "change123!"
    }
  }

  lifecycle {
    ignore_changes = [environment]
  }

  tags = {
    Name = local.function_name
  }

  depends_on = [aws_cloudwatch_log_group.log_group]
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = local.log_group_name
  retention_in_days = var.logging_retention
  tags = {
    Name = local.log_group_name
  }
}