resource "aws_iam_policy" "app_policy" {
  count       = var.create_app_policy ? 1 : 0
  name        = local.app_policy_name
  description = "Política para acesso à queue pela aplicação."
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "AllowSQS",
        "Effect" : "Allow",
        "Action" : [
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes",
          "sqs:SendMessage",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:PurgeQueue",
          "sqs:ChangeMessageVisibility",
        ],
        "Resource" : [
          aws_sqs_queue.queue.arn,
          aws_sqs_queue.dlq.arn
        ]
      }
    ]
  })
}
