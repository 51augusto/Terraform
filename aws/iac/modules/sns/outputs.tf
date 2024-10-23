output "app_policy" {
  value       = var.create_app_policy ? aws_iam_policy.app_policy[0] : null
  description = "Política de acesso para aplicações."
}

output "topic" {
  value       = aws_sns_topic.this
  description = "Tópico SNS"
}
