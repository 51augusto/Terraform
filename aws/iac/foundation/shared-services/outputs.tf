output "vpc_sae1_id" {
  value       = module.vpc_sae1.vpc_id
  description = "ID da VPC de SAE1"
}

output "vpc_sae1_public_subnets_ids" {
  value       = module.vpc_sae1.public_subnets
  description = "IDs da subnets públicas da VPC de SAE1"
}

output "vpc_sae1_private_subnets_ids" {
  value       = module.vpc_sae1.intra_subnets
  description = "IDs da subnets privadas da VPC de SAE1"
}

output "vpc_sae1_database_subnet_group_name" {
  value       = aws_db_subnet_group.db_subnet_group_sae1.name
  description = "Nome do database subnet group para RDS de SAE1."
}

output "vpc_sae1_redshift_subnet_group_name" {
  value       = aws_redshift_subnet_group.redshift_subnet_group_sae1.name
  description = "Nome do redshift subnet group para Redshifts de SAE1."
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
  description = "IDs da subnets públicas da VPC de USE1"
}

output "vpc_use1_private_subnets_ids" {
  value       = module.vpc_use1.intra_subnets
  description = "IDs da subnets privadas da VPC de USE1"
}

output "vpc_use1_databricks_subnets_ids" {
  value       = [for i in aws_subnet.databricks_network : i.id]
  description = "IDs da subnets privadas do Databricks de USE1"
}

output "vpc_use1_database_subnet_group_name" {
  value       = aws_db_subnet_group.db_subnet_group_use1.name
  description = "Nome do database subnet group para RDS de USE1."
}

output "vpc_use1_redshift_subnet_group_name" {
  value       = aws_redshift_subnet_group.redshift_subnet_group_use1.name
  description = "Nome do redshift subnet group para Redshifts de USE1."
}

output "vpc_use1_public_subnets_cidr_blocks" {
  value       = module.vpc_use1.public_subnets_cidr_blocks
  description = "CIDR blocks das subnets publicas da VPC de USE1"
}

output "vpc_use1_private_subnets_cidr_blocks" {
  value       = module.vpc_use1.intra_subnets_cidr_blocks
  description = "CIDR blocks das subnets privadas da VPC de USE1"
}

output "vpc_use1_databricks_subnets_cidr_blocks" {
  value       = [for i in local.databricks_subnets : i.cidr_block]
  description = "CIDR blocks das subnets do Databricks de USE1"
}

output "resolver_rule_use1" {
  value       = aws_route53_resolver_rule.outbound_rule_use1.id
  description = "Rule do Outbound Endpoint do Route 53 Resolver"
}

output "resolver_rule_sae1" {
  value       = aws_route53_resolver_rule.outbound_rule_sae1.id
  description = "Rule do Outbound Endpoint do Route 53 Resolver"
}

output "resolver_rule_galgo_use1" {
  value       = aws_route53_resolver_rule.outbound_rule_galgo_use1.id
  description = "Rule do Outbound Endpoint do Route 53 Resolver"
}

output "resolver_rule_galgo_sae1" {
  value       = aws_route53_resolver_rule.outbound_rule_galgo_sae1.id
  description = "Rule do Outbound Endpoint do Route 53 Resolver"
}

output "resolver_rule_cloud_use1" {
  value       = aws_route53_resolver_rule.outbound_rule_cloud_use1.id
  description = "Rule 2 do Outbound Endpoint do Route 53 Resolver"
}

output "resolver_rule_cloud_sae1" {
  value       = aws_route53_resolver_rule.outbound_rule_cloud_sae1.id
  description = "Rule 2 do Outbound Endpoint do Route 53 Resolver"
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