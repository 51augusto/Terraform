output "instance" {
  value       = aws_instance.instance
  description = "Instância EC2."
}

output "role" {
  value       = var.role == null ? aws_iam_role.role[0] : null
  description = "Role da instância EC2."
}

output "security_group" {
  value       = aws_security_group.sg
  description = "Security Group da instância EC2."
}
