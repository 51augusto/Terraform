resource "aws_iam_role" "role" {
  name               = local.role_name
  description        = "Role da função Lambda ${local.function_name}"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = concat(
    [aws_iam_policy.logs_policy.arn],
    var.vpc_config != null ? [aws_iam_policy.vpc_policy[0].arn] : [],
    var.tracing_config != null ? [aws_iam_policy.xray_policy[0].arn] : [],
    var.policy_arns
  )
  tags = {
    Name = local.role_name
  }
}

resource "aws_iam_policy" "logs_policy" {
  name        = local.logs_policy_name
  description = "Política para envio de logs da função Lambda ${local.function_name} ao CloudWatch."
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

resource "aws_iam_policy" "vpc_policy" {
  count       = var.vpc_config != null ? 1 : 0
  name        = local.vpc_policy_name
  description = "Política para gestão de ENIs da função Lambda ${local.function_name}."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ],
        "Resource" : "*"
      }
    ]
  })
  tags = {
    Name = local.vpc_policy_name
  }
}

resource "aws_iam_policy" "xray_policy" {
  count       = var.tracing_config != null ? 1 : 0
  name        = local.xray_policy_name
  description = "Política para integração da função Lambda ${local.function_name} ao X-Ray."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "xray:PutTraceSegments",
          "xray:PutTelemetryRecords",
          "xray:GetSamplingRules",
          "xray:GetSamplingTargets",
          "xray:GetSamplingStatisticSummaries"
        ],
        "Resource" : [
          "*"
        ]
      }
    ]
  })
  tags = {
    Name = local.xray_policy_name
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
          "lambda:GetFunctionConfiguration"
        ],
        "Resource" : aws_lambda_function.lambda_function.arn
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

resource "aws_iam_policy" "ops_policy" {
  count       = var.create_ops_policy ? 1 : 0
  name        = local.ops_policy_name
  description = "Política para acesso à function pelas ferramentas de Operações."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction"
        ],
        "Resource" : aws_lambda_function.lambda_function.arn
      }
    ]
  })
}

resource "aws_iam_policy" "app_policy" {
  count       = var.create_app_policy ? 1 : 0
  name        = local.app_policy_name
  description = "Política para acesso à function por outras aplicações."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction"
        ],
        "Resource" : aws_lambda_function.lambda_function.arn
      }
    ]
  })
}