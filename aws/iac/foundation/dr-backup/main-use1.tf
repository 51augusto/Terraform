module "vpc_use1" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "5.17.0"
  providers = { aws = aws.use1 }

  name = "dr-backup"
  cidr = "10.86.0.0/16"

  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  intra_subnets  = ["10.86.20.0/22", "10.86.24.0/22", "10.86.28.0/22"]
  public_subnets = ["10.86.0.0/22", "10.86.4.0/22", "10.86.8.0/22"]

  single_nat_gateway            = false
  one_nat_gateway_per_az        = false
  enable_nat_gateway            = false
  map_public_ip_on_launch       = true
  manage_default_security_group = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  igw_tags         = module.this_use1.igw_tags
  nat_gateway_tags = module.this_use1.nat_gw_tags
  vpc_tags         = module.this_use1.vpc_tags

  manage_default_network_acl   = true
  public_dedicated_network_acl = true
  intra_dedicated_network_acl  = true

  manage_default_route_table = true
  default_route_table_tags   = module.this_use1.rtb_default_tags

  nat_eip_tags = module.this_use1.eip_tags

  public_subnet_tags = merge(module.this_use1.subnet_public_tags, var.public_subnets_use1_tags)
  intra_subnet_tags  = merge(module.this_use1.subnet_private_tags, var.private_subnets_use1_tags)

  public_route_table_tags = module.this_use1.rtb_public_tags
  intra_route_table_tags  = module.this_use1.rtb_private_tags

  public_acl_tags          = module.this_use1.network_acl_public_tags
  intra_acl_tags           = module.this_use1.network_acl_private_tags
  default_network_acl_tags = module.this_use1.network_acl_default_tags

  intra_inbound_acl_rules  = local.network_acls_use1["default"]
  intra_outbound_acl_rules = local.network_acls_use1["default"]
}

resource "aws_ec2_transit_gateway_vpc_attachment" "dr_backup_use1" {
  provider           = aws.use1
  tags               = module.this_use1.tgw_attachment_vpc_tags
  subnet_ids         = module.vpc_use1.intra_subnets
  transit_gateway_id = data.terraform_remote_state.network.outputs.tgw_use1_id
  vpc_id             = module.vpc_use1.vpc_id
}

resource "aws_route" "dr_backup_use1_internet" {
  provider               = aws.use1
  count                  = length(module.vpc_use1.intra_route_table_ids)
  route_table_id         = module.vpc_use1.intra_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_use1_id
}

resource "aws_vpc_endpoint" "s3_use1_gateway_interno" {
  provider        = aws.use1
  vpc_id          = module.vpc_use1.vpc_id
  service_name    = "com.amazonaws.us-east-1.s3"
  route_table_ids = setunion(module.vpc_use1.intra_route_table_ids, module.vpc_use1.database_route_table_ids)

  tags = {
    Name = local.s3_use1_endpoint_gateway_interno
  }
}