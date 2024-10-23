module "vpc_sae1" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "5.0.0"
  providers = { aws = aws.sae1 }

  name = "dr-backup"
  cidr = "10.96.0.0/16"

  azs            = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
  intra_subnets  = ["10.96.20.0/22", "10.96.24.0/22", "10.96.28.0/22"]
  public_subnets = ["10.96.0.0/22", "10.96.4.0/22", "10.96.8.0/22"]

  single_nat_gateway            = false
  one_nat_gateway_per_az        = false
  enable_nat_gateway            = false
  map_public_ip_on_launch       = true
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  igw_tags         = module.this_sae1.igw_tags
  nat_gateway_tags = module.this_sae1.nat_gw_tags
  vpc_tags         = module.this_sae1.vpc_tags

  manage_default_network_acl   = true
  public_dedicated_network_acl = true
  intra_dedicated_network_acl  = true

  manage_default_route_table = true
  default_route_table_tags   = module.this_sae1.rtb_default_tags

  nat_eip_tags = module.this_sae1.eip_tags

  public_subnet_tags = merge(module.this_sae1.subnet_public_tags, var.public_subnets_sae1_tags)
  intra_subnet_tags  = merge(module.this_sae1.subnet_private_tags, var.private_subnets_sae1_tags)

  public_route_table_tags = module.this_sae1.rtb_public_tags
  intra_route_table_tags  = module.this_sae1.rtb_private_tags

  public_acl_tags          = module.this_sae1.network_acl_public_tags
  intra_acl_tags           = module.this_sae1.network_acl_private_tags
  default_network_acl_tags = module.this_sae1.network_acl_default_tags

  intra_inbound_acl_rules  = local.network_acls_sae1["default"]
  intra_outbound_acl_rules = local.network_acls_sae1["default"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "dr_backup_sae1" {
  provider           = aws.sae1
  tags               = module.this_sae1.tgw_attachment_vpc_tags
  subnet_ids         = module.vpc_sae1.intra_subnets
  transit_gateway_id = data.terraform_remote_state.network.outputs.tgw_sae1_id
  vpc_id             = module.vpc_sae1.vpc_id
}

resource "aws_route" "dr_backup_sae1_internet" {
  provider               = aws.sae1
  count                  = length(module.vpc_sae1.intra_route_table_ids)
  route_table_id         = module.vpc_sae1.intra_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_sae1_id
}

resource "aws_vpc_endpoint" "s3_sae1_gateway_interno" {
  provider        = aws.sae1
  vpc_id          = module.vpc_sae1.vpc_id
  service_name    = "com.amazonaws.sa-east-1.s3"
  route_table_ids = setunion(module.vpc_sae1.intra_route_table_ids, module.vpc_sae1.database_route_table_ids)

  tags = {
    Name = local.s3_sae1_endpoint_gateway_interno
  }
}