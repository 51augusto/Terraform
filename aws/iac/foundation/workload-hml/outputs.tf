output "vpc_sae1_id" {
  value       = module.vpc_sae1.vpc_id
  description = "ID da VPC de SAE1"
}

output "vpc_sae1_public_subnets_ids" {
  value       = module.vpc_sae1.public_subnets
  description = "IDs das subnets públicas da VPC de SAE1"
}

output "vpc_sae1_private_subnets_ids" {
  value       = module.vpc_sae1.intra_subnets
  description = "IDs das subnets privadas da VPC de SAE1"
}

output "vpc_sae1_database_subnets_ids" {
  value       = module.vpc_sae1.database_subnets
  description = "IDs das subnets de database da VPC de SAE1"
}

output "vpc_sae1_database_subnets_cidr_blocks" {
  value       = module.vpc_sae1.database_subnets_cidr_blocks
  description = "CIDR blocks das subnets de database da VPC de SAE1"
}

output "vpc_sae1_database_subnet_group_name" {
  description = "Nome do database subnet group para RDS de SAE1."
  value       = module.vpc_sae1.database_subnet_group_name
}

output "vpc_sae1_elasticache_subnet_group_name" {
  value       = aws_elasticache_subnet_group.elasticache_subnet_group_sae1.name
  description = "Nome do elasticache subnet group para Elasticaches de SAE1."
}

output "vpc_sae1_public_subnets_cidr_blocks" {
  value       = module.vpc_sae1.public_subnets_cidr_blocks
  description = "CIDR blocks das subnets publicas da VPC de SAE1"
}

output "vpc_sae1_private_subnets_cidr_blocks" {
  value       = module.vpc_sae1.intra_subnets_cidr_blocks
  description = "CIDR blocks das subnets privadas da VPC de SAE1"
}

output "vpc_use1_id" {
  value       = module.vpc_use1.vpc_id
  description = "ID da VPC de USE1"
}

output "vpc_use1_public_subnets_ids" {
  value       = module.vpc_use1.public_subnets
  description = "IDs das subnets públicas da VPC de USE1"
}

output "vpc_use1_private_subnets_ids" {
  value       = module.vpc_use1.intra_subnets
  description = "IDs das subnets privadas da VPC de USE1"
}

output "vpc_use1_database_subnets_ids" {
  value       = module.vpc_use1.database_subnets
  description = "IDs das subnets de database da VPC de USE1"
}

output "vpc_use1_database_subnets_cidr_blocks" {
  value       = module.vpc_use1.database_subnets_cidr_blocks
  description = "CIDR blocks das subnets de database da VPC de USE1"
}

output "vpc_use1_database_subnet_group_name" {
  value       = module.vpc_use1.database_subnet_group_name
  description = "Nome do database subnet group para RDS de USE1."
}

output "vpc_use1_elasticache_subnet_group_name" {
  value       = aws_elasticache_subnet_group.elasticache_subnet_group_use1.name
  description = "Nome do elasticache subnet group para Elasticaches de USE1."
}

output "vpc_use1_public_subnets_cidr_blocks" {
  value       = module.vpc_use1.public_subnets_cidr_blocks
  description = "CIDR blocks das subnets publicas da VPC de USE1"
}

output "vpc_use1_private_subnets_cidr_blocks" {
  value       = module.vpc_use1.intra_subnets_cidr_blocks
  description = "CIDR blocks das subnets privadas da VPC de USE1"
}

output "acm_use1_certificate_private" {
  value       = aws_acm_certificate.certificate_private_use1
  sensitive   = true
  description = "Certificado privado de us-east-1."
}

output "acm_sae1_certificate_private" {
  value       = aws_acm_certificate.certificate_private_sae1
  sensitive   = true
  description = "Certificado privado de sa-east-1."
}

output "acm_use1_certificate_public" {
  value       = aws_acm_certificate.certificate_public_use1
  sensitive   = true
  description = "Certificado público de us-east-1."
}

output "acm_sae1_certificate_public" {
  value       = aws_acm_certificate.certificate_public_sae1
  sensitive   = true
  description = "Certificado público de sa-east-1."
}