output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID da VPC"
}

output "vpc_public_subnets_ids" {
  value       = module.vpc.public_subnets
  description = "IDs da subnets públicas da VPC"
}

output "vpc_private_subnets_ids" {
  value       = module.vpc.intra_subnets
  description = "IDs da subnets privadas da VPC"
}

output "vpc_database_subnet_group_name" {
  value       = aws_db_subnet_group.wordpress.name
  description = "Nome do database subnet group para RDS de USE1."
}