output "roles_aws_auth" {
  description = "Lista de roles para serem configuradas no ConfigMap `aws-auth` ."
  value       = local.roles_aws_auth
}