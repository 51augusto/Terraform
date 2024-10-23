output "redis" {
  value       = aws_elasticache_replication_group.redis
  description = "Instância Redis."
}

output "security_group" {
  value       = aws_security_group.sg
  description = "Security Group da instância EC2."
}
