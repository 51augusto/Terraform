module "vpc_use1" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "5.15.0"
  providers = { aws = aws.use1 }

  name = "workload-prd"
  cidr = "10.62.0.0/16"

  azs              = ["us-east-1a", "us-east-1b", "us-east-1c"]
  intra_subnets    = ["10.62.20.0/22", "10.62.24.0/22", "10.62.28.0/22"]
  public_subnets   = ["10.62.0.0/22", "10.62.4.0/22", "10.62.8.0/22"]
  database_subnets = ["10.62.40.0/22", "10.62.44.0/22", "10.62.48.0/22"]

  single_nat_gateway            = true
  one_nat_gateway_per_az        = false
  enable_nat_gateway            = false
  map_public_ip_on_launch       = true
  manage_default_security_group = false

  enable_dns_support   = true
  enable_dns_hostnames = true

  igw_tags         = module.this_use1.igw_tags
  nat_gateway_tags = module.this_use1.nat_gw_tags
  vpc_tags         = module.this_use1.vpc_tags

  manage_default_network_acl     = true
  public_dedicated_network_acl   = true
  intra_dedicated_network_acl    = true
  database_dedicated_network_acl = true

  manage_default_route_table         = true
  create_database_subnet_route_table = true
  default_route_table_tags           = module.this_use1.rtb_default_tags

  nat_eip_tags = module.this_use1.eip_tags

  public_subnet_tags = merge(module.this_use1.subnet_public_tags, var.public_subnets_use1_tags)
  intra_subnet_tags  = merge(module.this_use1.subnet_private_tags, var.private_subnets_use1_tags)

  database_subnet_tags = module.this_use1.subnet_database_tags

  public_route_table_tags   = module.this_use1.rtb_public_tags
  intra_route_table_tags    = module.this_use1.rtb_private_tags
  database_route_table_tags = module.this_use1.rtb_database_tags

  public_acl_tags          = module.this_use1.network_acl_public_tags
  intra_acl_tags           = module.this_use1.network_acl_private_tags
  database_acl_tags        = module.this_use1.network_acl_database_tags
  default_network_acl_tags = module.this_use1.network_acl_default_tags

  intra_inbound_acl_rules     = local.network_acls_use1["default"]
  intra_outbound_acl_rules    = local.network_acls_use1["default"]
  database_inbound_acl_rules  = local.network_acls_use1["default"]
  database_outbound_acl_rules = local.network_acls_use1["default"]

  database_subnet_group_name = "subnetgroup-rds-${module.this_use1.custom_context_id}"
  database_subnet_group_tags = {
    Name = "subnetgroup-rds-${module.this_use1.custom_context_id}"
  }
}

resource "aws_elasticache_subnet_group" "elasticache_subnet_group_use1" {
  provider   = aws.use1
  name       = local.elasticache_subnet_group_use1_name
  subnet_ids = module.vpc_use1.database_subnets
  tags = {
    Name = local.elasticache_subnet_group_use1_name
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "workload_prd_use1" {
  provider           = aws.use1
  subnet_ids         = module.vpc_use1.intra_subnets
  transit_gateway_id = data.terraform_remote_state.network.outputs.tgw_use1_id
  vpc_id             = module.vpc_use1.vpc_id
  tags               = module.this_use1.tgw_attachment_vpc_tags
}

resource "aws_route" "workload_prd_use1_route_intra2internet" {
  count                  = length(module.vpc_use1.intra_route_table_ids)
  provider               = aws.use1
  route_table_id         = module.vpc_use1.intra_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_use1_id
}

resource "aws_route" "workload_prd_use1_route_db2internet" {
  count                  = length(module.vpc_use1.database_route_table_ids)
  provider               = aws.use1
  route_table_id         = module.vpc_use1.database_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_use1_id
}

resource "aws_vpc_endpoint" "s3_gateway_interno" {
  provider        = aws.use1
  vpc_id          = module.vpc_use1.vpc_id
  service_name    = "com.amazonaws.us-east-1.s3"
  route_table_ids = setunion(module.vpc_use1.intra_route_table_ids, module.vpc_use1.database_route_table_ids)

  tags = {
    Name = local.s3_use1_endpoint_gateway_interno
  }
}