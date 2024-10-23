output "ecs_cluster_arn" {
  value       = module.ecs.cluster_arn
  description = "ARN do cluster ECS criado."
}

output "cicd_policy" {
  value       = var.create_cicd_policy ? aws_iam_policy.cicd_policy[0] : null
  description = "Política de acesso para CI/CD."
}