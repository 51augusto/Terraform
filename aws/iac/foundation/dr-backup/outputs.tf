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