output "ec2_role" {
  value       = var.ec2_polices_arns != null ? aws_iam_role.ec2_role[0] : null
  description = "Role para EC2."
}

output "eks_role" {
  value       = var.eks_applications != {} ? aws_iam_role.eks_role : null
  description = "Role para aplicações EKS."
}

output "eks_single_role" {
  value       = var.eks_polices_arns != null ? aws_iam_role.eks_single_role[0] : null
  description = "Role para EKS."
}

output "ecs_role" {
  value       = var.ecs_applications != {} ? aws_iam_role.ecs_role : null
  description = "Role para aplicações ECS."
}

output "cicd_role" {
  value       = aws_iam_role.cicd_role
  description = "Role para CI/CD."
}

output "ops_role" {
  value       = aws_iam_role.ops_role
  description = "Role para Operações."
}
