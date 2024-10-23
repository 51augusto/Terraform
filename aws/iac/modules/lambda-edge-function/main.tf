resource "aws_lambda_function" "lambda_edge_function" {
  function_name = local.function_name
  description   = local.description
  role          = aws_iam_role.role.arn
  architectures = var.architectures
  layers        = var.layers
  runtime       = var.runtime
  filename      = var.filename == null ? "${path.module}/${local.runtimes[var.runtime].filename}" : var.filename
  handler       = var.handler
  publish       = true
  tags = {
    Name = local.function_name
  }
  depends_on = [aws_cloudwatch_log_group.log_group]

  lifecycle {
    # Atributos que podem ser alterados via Pipeline
    ignore_changes = [handler, timeout, memory_size, environment, layers]
  }

}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = local.log_group_name
  retention_in_days = var.logging_retention
  tags = {
    Name = local.log_group_name
  }
}
