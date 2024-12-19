module "vpc_use1" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "5.17.0"
  providers = { aws = aws.use1 }

  name = "shared-services"
  cidr = "10.82.0.0/16"

  azs            = ["us-east-1a", "us-east-1b", "us-east-1c"]
  intra_subnets  = ["10.82.20.0/22", "10.82.24.0/22", "10.82.28.0/22"]
  public_subnets = ["10.82.0.0/22", "10.82.4.0/22", "10.82.8.0/22"]

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
}

resource "aws_db_subnet_group" "db_subnet_group_use1" {
  provider   = aws.use1
  name       = local.db_subnet_group_use1_name
  subnet_ids = module.vpc_use1.intra_subnets
  tags = {
    Name = local.db_subnet_group_use1_name
  }
}

resource "aws_redshift_subnet_group" "redshift_subnet_group_use1" {
  provider   = aws.use1
  name       = local.redshift_subnet_group_use1_name
  subnet_ids = module.vpc_use1.intra_subnets

  tags = {
    Name = local.redshift_subnet_group_use1_name
  }
}

resource "aws_ec2_transit_gateway_vpc_attachment" "shared_services_use1" {
  provider           = aws.use1
  tags               = module.this_use1.tgw_attachment_vpc_tags
  subnet_ids         = module.vpc_use1.intra_subnets
  transit_gateway_id = data.terraform_remote_state.network.outputs.tgw_use1_id
  vpc_id             = module.vpc_use1.vpc_id
}

resource "aws_route" "shared_services_use1_internet" {
  provider               = aws.use1
  count                  = length(module.vpc_use1.intra_route_table_ids)
  route_table_id         = module.vpc_use1.intra_route_table_ids[count.index]
  destination_cidr_block = "0.0.0.0/0"
  transit_gateway_id     = data.terraform_remote_state.network.outputs.tgw_use1_id
}

resource "aws_ec2_tag" "r53_resolver_endpoints_map_migrated_use1" {
  for_each    = toset(local.r53_resolver_endpoints_enis_use1)
  provider    = aws.use1
  resource_id = each.key
  key         = "map-migrated"
  value       = "d-server-01oiau1h5afqhv"
}