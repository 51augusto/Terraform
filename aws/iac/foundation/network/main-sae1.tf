module "vpc_egress_sae1" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "5.17.0"
  providers = { aws = aws.sae1 }
  name      = "egress"
  cidr      = "10.91.0.0/16"

  azs             = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
  private_subnets = ["10.91.20.0/22", "10.91.24.0/22", "10.91.28.0/22"]
  public_subnets  = ["10.91.0.0/22", "10.91.4.0/22", "10.91.8.0/22"]

  single_nat_gateway            = false
  one_nat_gateway_per_az        = true
  enable_nat_gateway            = true
  map_public_ip_on_launch       = true
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  igw_tags         = module.this_sae1["vpc_egress"].igw_tags
  nat_gateway_tags = module.this_sae1["vpc_egress"].nat_gw_tags
  vpc_tags         = module.this_sae1["vpc_egress"].vpc_tags

  manage_default_network_acl    = true
  public_dedicated_network_acl  = true
  private_dedicated_network_acl = true

  manage_default_route_table = true
  default_route_table_tags   = module.this_sae1["vpc_egress"].rtb_default_tags

  nat_eip_tags = module.this_sae1["vpc_egress"].eip_tags

  public_subnet_tags  = module.this_sae1["vpc_egress"].subnet_public_tags
  private_subnet_tags = module.this_sae1["vpc_egress"].subnet_private_tags

  public_route_table_tags  = module.this_sae1["vpc_egress"].rtb_public_tags
  private_route_table_tags = module.this_sae1["vpc_egress"].rtb_private_tags

  public_acl_tags          = module.this_sae1["vpc_egress"].network_acl_public_tags
  private_acl_tags         = module.this_sae1["vpc_egress"].network_acl_private_tags
  default_network_acl_tags = module.this_sae1["vpc_egress"].network_acl_default_tags
}

resource "aws_route" "vpc_egress_sae1_public_rtb_workloads" {
  provider               = aws.sae1
  for_each               = var.tgw_attachments_sae1
  route_table_id         = module.vpc_egress_sae1.public_route_table_ids[0]
  destination_cidr_block = each.value.cidr_block
  transit_gateway_id     = module.tgw_sae1.ec2_transit_gateway_id
  depends_on             = [module.vpc_egress_sae1]
}

module "tgw_sae1" {
  source      = "terraform-aws-modules/transit-gateway/aws"
  version     = "2.12.2"
  providers   = { aws = aws.sae1 }
  name        = module.this_sae1["shared"].tgw_id
  description = "Transit Gateway de sae1 compartilhado com todas as contas da Organizacao."

  share_tgw                              = true
  enable_auto_accept_shared_attachments  = true
  enable_default_route_table_association = false
  enable_default_route_table_propagation = false

  amazon_side_asn = "64512"

  vpc_attachments = {
    vpc = {
      vpc_id                                          = module.vpc_egress_sae1.vpc_id
      subnet_ids                                      = module.vpc_egress_sae1.private_subnets
      dns_support                                     = true
      ipv6_support                                    = false
      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false
    }
  }

  ram_name                      = "${module.this_sae1["shared"].ram_id}-tgw"
  ram_tags                      = { Name = "${module.this_sae1["shared"].ram_id}-tgw" }
  tgw_default_route_table_tags  = { Name = "${module.this_sae1["shared"].tgw_rtb_id}-default" }
  tgw_route_table_tags          = { Name = "${module.this_sae1["shared"].tgw_rtb_id}-egress" }
  tgw_vpc_attachment_tags       = module.this_sae1["vpc_egress"].tgw_attachment_vpc_tags
  ram_allow_external_principals = false
  ram_principals                = [data.aws_organizations_organization.org.arn]
}

resource "aws_ec2_transit_gateway_route_table" "workloads_sae1" {
  transit_gateway_id = module.tgw_sae1.ec2_transit_gateway_id
  provider           = aws.sae1
  tags = {
    Name = "${module.this_sae1["shared"].tgw_rtb_id}-workloads"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "workloads_sae1" {
  for_each                       = var.tgw_attachments_sae1
  provider                       = aws.sae1
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_sae1.id
}

resource "aws_ec2_transit_gateway_route" "workloads_internet_sae1" {
  destination_cidr_block         = "0.0.0.0/0"
  provider                       = aws.sae1
  transit_gateway_attachment_id  = module.tgw_sae1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_sae1.id
}

resource "aws_ec2_transit_gateway_route" "workloads_intra_communication_sae1" {
  for_each                       = merge(var.tgw_attachments_sae1, { vpc_egress = { tgw_attachment_id = module.tgw_sae1.ec2_transit_gateway_vpc_attachment_ids[0], cidr_block = module.vpc_egress_sae1.vpc_cidr_block } })
  provider                       = aws.sae1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_sae1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "workloads_to_bgp_on_prem_routes_sae1" {
  provider                       = aws.sae1
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.sae1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_sae1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "workloads_vpn_connetion_sae1" {
  provider                       = aws.sae1
  transit_gateway_attachment_id  = aws_vpn_connection.sae1.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_sae1.id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "egress_to_bgp_on_prem_routes_sae1" {
  provider                       = aws.sae1
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.sae1.id
  transit_gateway_route_table_id = module.tgw_sae1.ec2_transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table_propagation" "egress_vpn_connetion_sae1" {
  provider                       = aws.sae1
  transit_gateway_attachment_id  = aws_vpn_connection.sae1.transit_gateway_attachment_id
  transit_gateway_route_table_id = module.tgw_sae1.ec2_transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route_table" "on_prem_sae1" {
  transit_gateway_id = module.tgw_sae1.ec2_transit_gateway_id
  provider           = aws.sae1
  tags = {
    Name = "${module.this_sae1["shared"].tgw_rtb_id}-on-prem"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "on_prem_dx_gw_sae1" {
  provider                       = aws.sae1
  transit_gateway_attachment_id  = data.aws_ec2_transit_gateway_dx_gateway_attachment.sae1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.on_prem_sae1.id
}

resource "aws_ec2_transit_gateway_route_table_association" "on_prem_vpn_sae1" {
  provider                       = aws.sae1
  transit_gateway_attachment_id  = aws_vpn_connection.sae1.transit_gateway_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.on_prem_sae1.id
}

resource "aws_ec2_transit_gateway_route" "on_prem_to_egress_sae1" {
  provider                       = aws.sae1
  destination_cidr_block         = module.vpc_egress_sae1.vpc_cidr_block
  transit_gateway_attachment_id  = module.tgw_sae1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.on_prem_sae1.id
}

resource "aws_ec2_transit_gateway_route" "on_prem_to_workloads_sae1" {
  for_each                       = { for k, v in var.tgw_attachments_sae1 : k => v if v.on_prem }
  provider                       = aws.sae1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.on_prem_sae1.id
}

resource "aws_ec2_transit_gateway_route" "egress_to_workloads_sae1" {
  for_each                       = var.tgw_attachments_sae1
  provider                       = aws.sae1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = module.tgw_sae1.ec2_transit_gateway_route_table_id
}

resource "aws_ec2_transit_gateway_route" "workloads_to_egress_sae1" {
  provider                       = aws.sae1
  destination_cidr_block         = module.vpc_egress_sae1.vpc_cidr_block
  transit_gateway_attachment_id  = module.tgw_sae1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_sae1.id
}

resource "aws_ec2_transit_gateway_peering_attachment" "sae1_to_use1" {
  provider                = aws.sae1
  peer_region             = data.aws_region.use1.name
  peer_transit_gateway_id = module.tgw_use1.ec2_transit_gateway_id
  transit_gateway_id      = module.tgw_sae1.ec2_transit_gateway_id

  tags = { Name = "${module.this_sae1["shared"].tgw_attachment_peering_id}-peering-to-use1" }
}

resource "aws_ec2_transit_gateway_route" "workloads_cross_region_use1_communication_sae1" {
  for_each                       = var.tgw_attachments_use1
  provider                       = aws.sae1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.sae1_to_use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_sae1.id
  depends_on                     = [aws_ec2_transit_gateway_peering_attachment_accepter.sae1_to_use1]
}

resource "aws_ec2_transit_gateway_route_table" "peering_sae1" {
  transit_gateway_id = module.tgw_sae1.ec2_transit_gateway_id
  provider           = aws.sae1
  tags = {
    Name = "${module.this_sae1["shared"].tgw_rtb_id}-peering-to-use1"
  }
}

resource "aws_ec2_transit_gateway_route_table_association" "peering_sae1" {
  provider                       = aws.sae1
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.sae1_to_use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_sae1.id
}

resource "aws_ec2_transit_gateway_route" "peering_attach_use1_sae1" {
  for_each                       = var.tgw_attachments_use1
  provider                       = aws.sae1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = aws_ec2_transit_gateway_peering_attachment.sae1_to_use1.id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_sae1.id
}

resource "aws_ec2_transit_gateway_route" "peering_to_egress_sae1" {
  provider                       = aws.sae1
  destination_cidr_block         = module.vpc_egress_sae1.vpc_cidr_block
  transit_gateway_attachment_id  = module.tgw_sae1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_sae1.id
}


resource "aws_ec2_transit_gateway_route" "peering_attach_local_sae1" {
  for_each                       = var.tgw_attachments_sae1
  provider                       = aws.sae1
  destination_cidr_block         = each.value.cidr_block
  transit_gateway_attachment_id  = each.value.tgw_attachment_id
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.peering_sae1.id
}

##############################
# TAGS TGW ATTACHMENT VPC
##############################

resource "aws_ec2_tag" "vpc_attachments_name_sae1" {
  for_each    = var.tgw_attachments_sae1
  provider    = aws.sae1
  resource_id = each.value.tgw_attachment_id
  key         = "Name"
  value       = "tgw-attachment-vpc-${each.value.name}-${local.sa_east_1}-${each.value.suffix}"
}

resource "aws_ec2_tag" "vpc_attachments_map_migrated_sae1" {
  for_each    = var.tgw_attachments_sae1
  provider    = aws.sae1
  resource_id = each.value.tgw_attachment_id
  key         = "map-migrated"
  value       = var.tags["map-migrated"]
}

resource "aws_ec2_tag" "vpc_attachments_iac_sae1" {
  for_each    = var.tgw_attachments_sae1
  provider    = aws.sae1
  resource_id = each.value.tgw_attachment_id
  key         = "IAC"
  value       = "true"
}

resource "aws_ec2_tag" "vpc_attachments_environment_sae1" {
  for_each    = var.tgw_attachments_sae1
  provider    = aws.sae1
  resource_id = each.value.tgw_attachment_id
  key         = "Environment"
  value       = replace(each.value.name, "internal-", "")
}