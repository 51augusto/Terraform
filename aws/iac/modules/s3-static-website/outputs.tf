output "website" {
  value       = module.website
  description = "Website no CloudFront."
}

output "bucket" {
  value       = module.bucket
  description = "Bucket de conteúdo do Website."
}

output "cicd_policy" {
  value       = var.create_cicd_policy ? aws_iam_policy.cicd_policy[0] : null
  description = "Política de acesso para CI/CD."
}