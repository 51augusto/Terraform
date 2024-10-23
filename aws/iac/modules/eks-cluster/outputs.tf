output "worker_iam_role_arn" {
  value       = module.eks.worker_iam_role_arn
  description = "ARN da role dos workers"
}

output "worker_security_group_id" {
  value       = module.eks.worker_security_group_id
  description = "ID do SG dos workers"
}

output "eks_cluster_name" {
  value       = module.eks.cluster_id
  description = "Nome do cluster EKS"
}

output "eks_cluster_arn" {
  value       = module.eks.cluster_arn
  description = "ARN do cluster EKS"
}

output "eks_cluster_certificate_authority_data" {
  description = "Certificado base64 decodificado."
  value       = module.eks.cluster_certificate_authority_data
}

output "eks_cluster_endpoint" {
  description = "Endpoint da API do Kubernetes."
  value       = module.eks.cluster_endpoint
}

output "eks_cluster_oidc_provider_arn" {
  description = "ARN do OIDC Provider do Kubernetes."
  value       = module.eks.oidc_provider_arn
}