module "vpc_sae1" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "5.0.0"
  providers = { aws = aws.sae1 }

  name = "workload-dev"
  cidr = "10.58.0.0/16"

  azs              = ["sa-east-1a", "sa-east-1b", "sa-east-1c"]
  intra_subnets    = ["10.58.20.0/22", "10.58.24.0/22", "10.58.28.0/22"]
  public_subnets   = ["10.58.0.0/22", "10.58.4.0/22", "10.58.8.0/22"]
  database_subnets = ["10.58.40.0/22", "10.58.44.0/22", "10.58.48.0/22"]

  single_nat_gateway            = true
  one_nat_gateway_per_az        = false
  enable_nat_gateway            = false
  map_public_ip_on_launch       = true
  manage_default_security_group = false

  enable_dns_support   = true
  enable_dns_hostnames = true

  igw_tags         = module.this_sae1.igw_tags
  nat_gateway_tags = module.this_sae1.nat_gw_tags
  vpc_tags         = module.this_sae1.vpc_tags

  manage_default_network_acl     = true
  public_dedicated_network_acl   = true
  intra_dedicated_network_acl    = true
  database_dedicated_network_acl = true

  manage_default_route_table         = true
  create_database_subnet_route_table = true
  default_route_table_tags           = module.this_sae1.rtb_default_tags

  nat_eip_tags = module.this_sae1.eip_tags

  public_subnet_tags   = merge(module.this_sae1.subnet_public_tags, var.public_subnets_sae1_tags)
  intra_subnet_tags    = merge(module.this_sae1.subnet_private_tags, var.private_subnets_sae1_tags)
  database_subnet_tags = module.this_sae1.subnet_database_tags

  public_route_table_tags   = module.this_sae1.rtb_public_tags
  intra_route_table_tags    = module.this_sae1.rtb_private_tags
  database_route_table_tags = module.this_sae1.rtb_database_tags

  public_acl_tags          = module.this_sae1.network_acl_public_tags
  intra_acl_tags           = module.this_sae1.network_acl_private_tags
  database_acl_tags        = module.this_sae1.network_acl_database_tags
  default_network_acl_tags = module.this_sae1.network_acl_default_tags

  intra_inbound_acl_rules     = local.network_acls_sae1["default"]
  intra_outbound_acl_rules    = local.network_acls_sae1["default"]
  database_inbound_acl_rules  = local.network_acls_sae1["default"]
  database_outbound_acl_rules = local.network_acls_sae1["default"]

  database_subnet_group_name = "subnetgroup-rds-${module.this_sae1.custom_context_id}"
  database_subnet_group_tags = {
    Name = "subnetgroup-rds-${module.this_sae1.custom_context_id}"
  }
}

resource "aws_elasticache_subnet_group" "elasticache_subnet_group_sae1" {
  provider   = aws.sae1
  name       = local.elasticache_subnet_group_sae1_name
  subnet_ids = module.vpc_sae1.database_subnets
  tags = {
    Name = local.elasticache_subnet_group_sae1_name
  }
}

/*
resource "aws_ec2_transit_gateway_vpc_attachment" "workload_dev_sae1" {
  provider           = aws.sae1
  tags               = module.this_sae1.tgw_attachment_vpc_tags
  subnet_ids         = module.vpc_sae1.intra_subnets
  transit_gateway_id = data.terraform_remote_state.network.outputs.tgw_sae1_id
  vpc_id             = module.vpc_sae1.vpc_id
}

resource "aws_route" "workload_dev_sae1_route_intra2internet" {
  count                  = length(module.vpc_sae1.intra_route_table_ids)
  provider               = aws.sae1
  route_table_id         = module.vpc_sae1.intra_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_sae1_id
}

resource "aws_route" "workload_dev_sae1_route_database2internet" {
  count                  = length(module.vpc_sae1.database_route_table_ids)
  provider               = aws.sae1
  route_table_id         = module.vpc_sae1.database_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_sae1_id
}
*/