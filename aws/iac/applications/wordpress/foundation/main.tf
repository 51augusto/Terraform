module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.15.0"

  name = "wordpress"
  cidr = "10.60.0.0/16"

  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  intra_subnets  = ["10.60.20.0/22", "10.60.24.0/22", "10.60.28.0/22"]
  public_subnets = ["10.60.0.0/22", "10.60.4.0/22", "10.60.8.0/22"]

  single_nat_gateway            = false
  one_nat_gateway_per_az        = false
  enable_nat_gateway            = false
  map_public_ip_on_launch       = true
  manage_default_security_group = false

  enable_dns_support   = true
  enable_dns_hostnames = true

  vpc_tags           = local.vpc_tags
  igw_tags           = local.igw_tags
  public_subnet_tags = local.public_subnet_tags
  intra_subnet_tags  = local.intra_subnet_tags

  manage_default_route_table = true
  default_route_table_tags   = local.rtb_default_tags
  public_route_table_tags    = local.rtb_public_tags
  intra_route_table_tags     = local.rtb_private_tags

  manage_default_network_acl   = true
  public_dedicated_network_acl = true
  intra_dedicated_network_acl  = true
  default_network_acl_tags     = local.nacl_default_tags
  public_acl_tags              = local.nacl_public_tags
  intra_acl_tags               = local.nacl_private_tags
  intra_inbound_acl_rules      = local.network_acls_wp
  intra_outbound_acl_rules     = local.network_acls_wp
}

resource "aws_ec2_transit_gateway_vpc_attachment" "wordpress" {
  subnet_ids         = module.vpc.intra_subnets
  transit_gateway_id = data.terraform_remote_state.network.outputs.tgw_use1_id
  vpc_id             = module.vpc.vpc_id
  tags               = local.tgw_attachment_tags
}

resource "aws_route" "wordpress" {
  count                  = length(module.vpc.intra_route_table_ids)
  route_table_id         = module.vpc.intra_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_use1_id
}

resource "aws_db_subnet_group" "wordpress" {
  name       = local.db_subnet_group_name
  subnet_ids = module.vpc.intra_subnets
  tags = {
    Name = local.db_subnet_group_name
  }
}