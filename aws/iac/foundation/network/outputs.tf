output "tgw_sae1_id" {
  value       = module.tgw_sae1.ec2_transit_gateway_id
  description = "ID do TGW de São Paulo."
}

output "tgw_use1_id" {
  value       = module.tgw_use1.ec2_transit_gateway_id
  description = "ID do TGW de Virgínia."
}

output "vpc_sae1_id" {
  value       = module.vpc_egress_sae1.vpc_id
  description = "ID da VPC de SAE1"
}

output "vpc_sae1_public_subnets_ids" {
  value       = module.vpc_egress_sae1.public_subnets
  description = "IDs das subnets públicas da VPC de SAE1"
}

output "vpc_sae1_private_subnets_ids" {
  value       = module.vpc_egress_sae1.private_subnets
  description = "IDs das subnets privadas da VPC de SAE1"
}

output "vpc_sae1_fw_mgmt_subnets_ids" {
  value       = [for i in aws_subnet.fw_mgmt_sae1 : i.id]
  description = "IDs das subnets de Firewall Mgmt da VPC de SAE1"
}

output "vpc_sae1_fw_heartbeat_subnets_ids" {
  value       = [for i in aws_subnet.fw_heartbeat_sae1 : i.id]
  description = "IDs das subnets de Firewall Heartbeat da VPC de SAE1"
}

output "vpc_sae1_fw_mgmt_subnets_cidr_blocks" {
  value       = [for i in aws_subnet.fw_mgmt_sae1 : i.cidr_block]
  description = "CIDR blocks das subnets de Firewall Mgmt da VPC de SAE1"
}

output "vpc_sae1_fw_heartbeat_subnets_cidr_blocks" {
  value       = [for i in aws_subnet.fw_heartbeat_sae1 : i.cidr_block]
  description = "CIDR blocks das subnets de Firewall Heartbeat da VPC de SAE1"
}

output "vpc_use1_id" {
  value       = module.vpc_egress_use1.vpc_id
  description = "ID da VPC de USE1"
}

output "vpc_use1_public_subnets_ids" {
  value       = module.vpc_egress_use1.public_subnets
  description = "IDs das subnets públicas da VPC de USE1"
}

output "vpc_use1_private_subnets_ids" {
  value       = module.vpc_egress_use1.private_subnets
  description = "IDs das subnets privadas da VPC de USE1"
}

output "vpc_use1_fw_mgmt_subnets_ids" {
  value       = [for i in aws_subnet.fw_mgmt_use1 : i.id]
  description = "IDs das subnets de Firewall Mgmt da VPC de USE1"
}

output "vpc_use1_fw_heartbeat_subnets_ids" {
  value       = [for i in aws_subnet.fw_heartbeat_use1 : i.id]
  description = "IDs das subnets de Firewall Heartbeat da VPC de USE1"
}

output "vpc_use1_fw_mgmt_subnets_cidr_blocks" {
  value       = [for i in aws_subnet.fw_mgmt_use1 : i.cidr_block]
  description = "CIDR blocks das subnets de Firewall Mgmt da VPC de USE1"
}

output "vpc_use1_fw_heartbeat_subnets_cidr_blocks" {
  value       = [for i in aws_subnet.fw_heartbeat_use1 : i.cidr_block]
  description = "CIDR blocks das subnets de Firewall Heartbeat da VPC de USE1"
}

output "anbima_cidrs_pl_use1_id" {
  value       = aws_ec2_managed_prefix_list.anbima_cidrs_use1.id
  description = "ID do prefix list com os ranges de IP da rede interna da ANBIMA"
}

output "anbima_dc_cidrs_pl_use1_id" {
  value       = aws_ec2_managed_prefix_list.anbima_dc_cidrs_use1.id
  description = "ID do prefix list com os ranges de IP do DC ANBIMA"
}

output "anbima_cidrs_pl_sae1_id" {
  value       = aws_ec2_managed_prefix_list.anbima_cidrs_sae1.id
  description = "ID do prefix list com os ranges de IP da rede interna da ANBIMA"
}

output "anbima_dc_cidrs_pl_sae1_id" {
  value       = aws_ec2_managed_prefix_list.anbima_dc_cidrs_sae1.id
  description = "ID do prefix list com os ranges de IP do DC ANBIMA"
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