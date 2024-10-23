module "vpc_egress_use1" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "5.14.0"
  providers = { aws = aws.use1 }
  name      = "egress"
  cidr      = "10.81.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.81.20.0/22", "10.81.24.0/22", "10.81.28.0/22"]
  public_subnets  = ["10.81.0.0/22", "10.81.4.0/22", "10.81.8.0/22"]

  single_nat_gateway            = false
  one_nat_gateway_per_az        = true
  enable_nat_gateway            = true
  map_public_ip_on_launch       = true
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  igw_tags         = module.this_use1["vpc_egress"].igw_tags
  nat_gateway_tags = module.this_use1["vpc_egress"].nat_gw_tags
  vpc_tags         = module.this_use1["vpc_egress"].vpc_tags

  manage_default_network_acl    = true
  public_dedicated_network_acl  = true
  private_dedicated_network_acl = true

  manage_default_route_table = true
  default_route_table_tags   = module.this_use1["vpc_egress"].rtb_default_tags

  nat_eip_tags = module.this_use1["vpc_egress"].eip_tags

  public_subnet_tags  = module.this_use1["vpc_egress"].subnet_public_tags
  private_subnet_tags = module.this_use1["vpc_egress"].subnet_private_tags

  public_route_table_tags  = module.this_use1["vpc_egress"].rtb_public_tags
  private_route_table_tags = module.this_use1["vpc_egress"].rtb_private_tags

  public_acl_tags          = module.this_use1["vpc_egress"].network_acl_public_tags
  private_acl_tags         = module.this_use1["vpc_egress"].network_acl_private_tags
  default_network_acl_tags = module.this_use1["vpc_egress"].network_acl_default_tags
}

resource "aws_route" "vpc_egress_use1_public_rtb_workloads" {
  provider               = aws.use1
  for_each               = var.tgw_attachments_use1
  route_table_id         = module.vpc_egress_use1.public_route_table_ids[0]
  destination_cidr_block = each.value.cidr_block
  transit_gateway_id     = module.tgw_use1.ec2_transit_gateway_id
  depends_on             = [module.vpc_egress_use1]
}

module "tgw_use1" {
  source      = "terraform-aws-modules/transit-gateway/aws"
  version     = "2.12.2"
  providers   = { aws = aws.use1 }
  name        = module.this_use1["shared"].tgw_id
  description = "Transit Gateway de use1 compartilhado com todas as contas da Organizacao."

  share_tgw                              = true
  enable_auto_accept_shared_attachments  = true
  enable_default_route_table_association = false
  enable_default_route_table_propagation = false

  amazon_side_asn = "64514"

  vpc_attachments = {
    vpc = {
      vpc_id                                          = module.vpc_egress_use1.vpc_id
      subnet_ids                                      = module.vpc_egress_use1.private_subnets
      dns_support                                     = true
      ipv6_support                                    = false
      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false
    }
  }

  ram_name                      = "${module.this_use1["shared"].ram_id}-tgw"
  ram_tags                      = { Name = "${module.this_use1["shared"].ram_id}-tgw" }
  tgw_default_route_table_tags  = { Name = "${module.this_use1["shared"].tgw_rtb_id}-default" }
  tgw_route_table_tags          = { Name = "${module.this_use1["shared"].tgw_rtb_id}-egress" }
  tgw_vpc_attachment_tags       = module.this_use1["vpc_egress"].tgw_attachment_vpc_tags
  ram_allow_external_principals = false
  ram_principals                = [data.aws_organizations_organization.org.arn]
}

resource "aws_ec2_transit_gateway_route_table" "workloads_use1" {
  transit_gateway_id = module.tgw_use1.ec2_transit_gateway_id
  provider           = aws.use1
  tags = {
    Name = "${module.this_use1["shared"].tgw_rtb_id}-workloads"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "workloads_use1" {
  for_each                       = var.tgw_attachments_use1
  provider                       = aws.use1
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_ec2_transit_gateway_route" "workloads_internet_use1" {
  destination_cidr_block         = "0.0.0.0/0"
  provider                       = aws.use1
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_ec2_transit_gateway_route" "workloads_intra_communication_use1" {
  for_each                       = var.tgw_attachments_use1
  provider                       = aws.use1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_ec2_transit_gateway_route" "workloads_cross_region_sae1_communication_use1" {
  for_each                       = var.tgw_attachments_sae1
  provider                       = aws.use1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.sae1_to_use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.sae1_to_use1]
}

resource "aws_ec2_transit_gateway_route_table" "on_prem_use1" {
  transit_gateway_id = module.tgw_use1.ec2_transit_gateway_id
  provider           = aws.use1
  tags = {
    Name = "${module.this_use1["shared"].tgw_rtb_id}-on-prem"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "on_prem_dx_gw_use1" {
  provider                       = aws.use1
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.on_prem_use1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "on_prem_vpn_use1" {
  provider                       = aws.use1
  transit_gateway_attachment_id  = aws_vpn_connection.use1.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.on_prem_use1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "workloads_to_bgp_on_prem_routes_use1" {
  provider                       = aws.use1
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "workloads_vpn_connetion_use1" {
  provider                       = aws.use1
  transit_gateway_attachment_id  = aws_vpn_connection.use1.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "egress_to_bgp_on_prem_routes_use1" {
  provider                       = aws.use1
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.use1.id
  transit_gateway_route_table_id = module.tgw_use1.ec2_transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpn_connetion_use1" {
  provider                       = aws.use1
  transit_gateway_attachment_id  = aws_vpn_connection.use1.transit_gateway_attachment_id
  transit_gateway_route_table_id = module.tgw_use1.ec2_transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route" "on_prem_to_workloads_use1" {
  for_each                       = { for k, v in var.tgw_attachments_use1 : k => v if v.on_prem }
  provider                       = aws.use1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.on_prem_use1.id
}

resource "aws_ec2_transit_gateway_route" "egress_to_workloads_use1" {
  for_each                       = var.tgw_attachments_use1
  provider                       = aws.use1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = module.tgw_use1.ec2_transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route" "workloads_to_egress_use1" {
  provider                       = aws.use1
  destination_cidr_block         = module.vpc_egress_use1.vpc_cidr_block
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_ec2_transit_gateway_peering_attachment_accepter" "sae1_to_use1" {
  provider                      = aws.use1
  transit_gateway_attachment_id = aws_ec2_transit_gateway_peering_attachment.sae1_to_use1.id

  tags = { Name = "${module.this_use1["shared"].tgw_attachment_peering_id}-peering-to-sae1" }
}

resource "aws_ec2_transit_gateway_route_table" "peering_use1" {
  transit_gateway_id = module.tgw_use1.ec2_transit_gateway_id
  provider           = aws.use1
  tags = {
    Name = "${module.this_use1["shared"].tgw_rtb_id}-peering-to-sae1"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "peering_use1" {
  provider                       = aws.use1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.sae1_to_use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_use1.id
}

resource "aws_ec2_transit_gateway_route" "peering_attach_sae1_use1" {
  for_each                       = var.tgw_attachments_sae1
  provider                       = aws.use1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.sae1_to_use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_use1.id
}

resource "aws_ec2_transit_gateway_route" "peering_attach_local_use1" {
  for_each                       = var.tgw_attachments_use1
  provider                       = aws.use1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_use1.id
}

resource "aws_ec2_transit_gateway_route" "peering_to_egress_use1" {
  provider                       = aws.use1
  destination_cidr_block         = module.vpc_egress_use1.vpc_cidr_block
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_use1.id
}

##############################
# TAGS TGW ATTACHMENT VPC
##############################

resource "aws_ec2_tag" "vpc_attachments_name_use1" {
  for_each    = var.tgw_attachments_use1
  provider    = aws.use1
  resource_id = each.value.tgw_attachment_id
  key         = "Name"
  value       = "tgw-attachment-vpc-${each.value.name}-${local.us_east_1}-${each.value.suffix}"
}

resource "aws_ec2_tag" "vpc_attachments_map_migrated_use1" {
  for_each    = var.tgw_attachments_use1
  provider    = aws.use1
  resource_id = each.value.tgw_attachment_id
  key         = "map-migrated"
  value       = var.tags["map-migrated"]
}

resource "aws_ec2_tag" "vpc_attachments_iac_use1" {
  for_each    = var.tgw_attachments_use1
  provider    = aws.use1
  resource_id = each.value.tgw_attachment_id
  key         = "IAC"
  value       = "true"
}

resource "aws_ec2_tag" "vpc_attachments_environment_use1" {
  for_each    = var.tgw_attachments_use1
  provider    = aws.use1
  resource_id = each.value.tgw_attachment_id
  key         = "Environment"
  value       = replace(each.value.name, "internal-", "")
}