resource "aws_iam_role" "role" {
  name        = local.role_name
  description = "Role da função Lambda@Edge ${local.function_name}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [{
      "Action" : "sts:AssumeRole",
      "Principal" : {
        "Service" : ["lambda.amazonaws.com", "edgelambda.amazonaws.com"]
      },
      "Effect" : "Allow"
    }]
  })
  managed_policy_arns = concat(
    [aws_iam_policy.logs_policy.arn],
    var.policy_arns
  )
  tags = {
    Name = local.role_name
  }
}

resource "aws_iam_policy" "logs_policy" {
  name        = local.logs_policy_name
  description = "Política para envio de logs da função Lambda@Edge ${local.function_name} ao CloudWatch."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        "Resource" : [
          "${aws_cloudwatch_log_group.log_group.arn}:*"
        ]
      }
    ]
  })
  tags = {
    Name = local.logs_policy_name
  }
}

resource "aws_iam_policy" "cicd_policy" {
  count       = var.create_cicd_policy ? 1 : 0
  name        = local.cicd_policy_name
  description = "Política para acesso à function pelos jobs de CI/CD."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:UpdateFunctionCode",
          "lambda:UpdateFunctionConfiguration",
          "lambda:GetFunctionConfiguration",
          "lambda:PublishVersion",
          "lambda:GetFunction",
          "lambda:EnableReplication"
        ],
        "Resource" : [
          aws_lambda_function.lambda_edge_function.arn,
          "${aws_lambda_function.lambda_edge_function.arn}:*"
        ]
      },
      {
        "Action" : [
          "lambda:ListLayerVersions",
          "lambda:GetLayerVersion"
        ],
        "Effect" : "Allow",
        "Resource" : "arn:aws:lambda:*:*:layer:*"
      }
    ]
  })
}

