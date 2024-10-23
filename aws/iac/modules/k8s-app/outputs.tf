output "k8s_namespace" {
  value       = local.k8s_namespace
  description = "Nome do namespace criado para a aplicação."
}

output "eks_sa_role" {
  value       = aws_iam_role.eks_sa_role
  description = "Role da service account criada para a aplicação."
}
