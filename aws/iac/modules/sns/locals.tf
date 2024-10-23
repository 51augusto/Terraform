locals {
  name_suffix     = var.fifo ? ".fifo" : ""
  topic_name      = "sns-${module.this.custom_context_id}-${var.name}${local.name_suffix}"
  app_policy_name = "policy-app-sns-${module.this.custom_context_id}-${var.name}"
  delivery_policy = var.delivery_policy != null ? jsonencode(var.delivery_policy) : local.default_delivery_policy

  default_delivery_policy = jsonencode(
    {
      http = {
        defaultHealthyRetryPolicy = {
          minDelayTarget     = 20,
          maxDelayTarget     = 20,
          numRetries         = 3,
          numMaxDelayRetries = 0,
          numNoDelayRetries  = 0,
          numMinDelayRetries = 0,
          backoffFunction    = "linear"
        },
        disableSubscriptionOverrides = false,
        defaultThrottlePolicy = {
          maxReceivesPerSecond = 1
        }
      }
    }
  )

  topic_policy = jsonencode({
    Version = "2012-10-17",
    Id      = "TopicPolicy-${local.topic_name}"
    Statement = setunion([
      {
        Sid    = "SNSPermissions"
        Effect = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = [
          "SNS:Subscribe",
          "SNS:SetTopicAttributes",
          "SNS:RemovePermission",
          "SNS:Receive",
          "SNS:Publish",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:AddPermission"
        ],
        Condition = {
          "StringEquals" = {
            "AWS:SourceOwner" = data.aws_caller_identity.current.account_id
          }
        }

        Resource = [aws_sns_topic.this.arn]
      }
      ],
      var.topic_policy
    )
  })
}