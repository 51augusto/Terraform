output "queue" {
  value       = aws_sqs_queue.queue
  description = "Fila SQS principal"
}

output "dlq" {
  value       = aws_sqs_queue.dlq
  description = "Fila SQS DLQ"
}

output "app_policy" {
  value       = var.create_app_policy ? aws_iam_policy.app_policy[0] : null
  description = "Política de acesso para aplicações."
}