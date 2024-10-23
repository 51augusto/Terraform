output "lambda_function" {
  value       = aws_lambda_function.lambda_function
  description = "Função Lambda."
}

output "sg" {
  value       = local.create_sg ? aws_security_group.sg[0] : null
  description = "Security Group da função Lambda."
}

output "cicd_policy" {
  value       = var.create_cicd_policy ? aws_iam_policy.cicd_policy[0] : null
  description = "Política de acesso para CI/CD."
}

output "ops_policy" {
  value       = var.create_ops_policy ? aws_iam_policy.ops_policy[0] : null
  description = "Política de acesso para ferramentas de Operações."
}

output "app_policy" {
  value       = var.create_app_policy ? aws_iam_policy.app_policy[0] : null
  description = "Política de acesso para aplicações."
}