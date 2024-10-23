resource "aws_iam_policy" "app_policy" {
  count       = var.create_app_policy ? 1 : 0
  name        = local.app_policy_name
  description = "Política para acesso à tabela pela aplicação."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSQS",
        "Effect" : "Allow",
        "Action" : [
          "dynamodb:GetItem",
          "dynamodb:BatchGetItem",
          "dynamodb:ConditionCheckItem",
          "dynamodb:Scan",
          "dynamodb:Query",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:DeleteItem",
          "dynamodb:BatchWriteItem",
          "dynamodb:PartiQLUpdate",
          "dynamodb:PartiQLSelect",
          "dynamodb:PartiQLInsert",
          "dynamodb:PartiQLDelete"
        ],
        "Resource" : [
          aws_dynamodb_table.table.arn,
          "${aws_dynamodb_table.table.arn}/*"
        ]
      }
    ]
  })
}
