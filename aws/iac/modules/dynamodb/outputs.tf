output "table" {
  value       = aws_dynamodb_table.table
  description = "Tabela do DynamoDB"
}

output "app_policy" {
  value       = var.create_app_policy ? aws_iam_policy.app_policy[0] : null
  description = "Política de acesso para aplicações."
}