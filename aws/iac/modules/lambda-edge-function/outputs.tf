output "lambda_edge_function" {
  value       = aws_lambda_function.lambda_edge_function
  description = "Função Lambda@Edge."
}

output "cicd_policy" {
  value       = var.create_cicd_policy ? aws_iam_policy.cicd_policy[0] : null
  description = "Política de acesso para CI/CD."
}
