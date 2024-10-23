output "hostname" {
  value       = aws_db_instance.db_instance.address
  description = "Hostname da instância do RDS."
}

output "port" {
  value       = aws_db_instance.db_instance.port
  description = "Porta da instância do RDS."
}

output "db_name" {
  value       = aws_db_instance.db_instance.db_name
  description = "Nome do schema da instância do RDS."
}