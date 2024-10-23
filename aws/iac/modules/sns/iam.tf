resource "aws_iam_policy" "app_policy" {
  count       = var.create_app_policy ? 1 : 0
  name        = local.app_policy_name
  description = "Política para acesso ao tópico pela aplicação."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSNS",
        "Effect" : "Allow",
        "Action" : [
          "sns:Publish",
          "sns:GetTopicAttributes",
          "sns:Subscribe"
        ],
        "Resource" : [
          aws_sns_topic.this.arn
        ]
      }
    ]
  })
}