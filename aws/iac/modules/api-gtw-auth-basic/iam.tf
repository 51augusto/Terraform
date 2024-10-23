resource "aws_iam_role" "auth_role" {
  name                = local.auth_role_name
  description         = "Role da API Authorizer ${local.authorizer_name}"
  assume_role_policy  = data.aws_iam_policy_document.apigateway_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.auth_policy.arn]
  tags = {
    Name = local.auth_role_name
  }
}

resource "aws_iam_policy" "auth_policy" {
  name        = local.auth_policy_name
  description = "Política a função Lambda ${local.authorizer_name}."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "lambda:InvokeFunction",
        ],
        "Resource" : [
          aws_lambda_function.lambda_function.arn
        ]
      }
    ]
  })
  tags = {
    Name = local.auth_policy_name
  }
}

resource "aws_iam_role" "lambda_role" {
  name                = local.lambda_role_name
  description         = "Role da função Lambda ${local.function_name}"
  assume_role_policy  = data.aws_iam_policy_document.lambda_assume_role_policy.json
  managed_policy_arns = [aws_iam_policy.lambda_policy.arn]
  tags = {
    Name = local.lambda_role_name
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name        = local.lambda_policy_name
  description = "Política a função Lambda ${local.function_name}."
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
    Name = local.lambda_policy_name
  }
}
