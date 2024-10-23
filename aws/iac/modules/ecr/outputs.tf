output "repository" {
  value       = aws_ecr_repository.ecr_repo
  description = "Repositório ECR"
}

output "pull_policy" {
  value       = var.create_pull_policy ? aws_iam_policy.pull_policy[0] : null
  description = "Política de pull de imagens do repositório."
}