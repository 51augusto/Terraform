locals {
  vpc_context = "${module.this.custom_context_id}-wordpress"
  vpc_tags = {
    Name = "vpc-${local.vpc_context}"
  }
  igw_tags = {
    Name = "igw-${local.vpc_context}"
  }
  public_subnet_tags = {
    Name = "subnet-${local.vpc_context}-public"
    tier = "public"
  }
  intra_subnet_tags = {
    Name = "subnet-${local.vpc_context}-private"
    tier = "private"
  }
  rtb_default_tags = {
    Name = "rtb-${local.vpc_context}-default"
  }
  rtb_public_tags = {
    Name = "rtb-${local.vpc_context}-public"
  }
  rtb_private_tags = {
    Name = "rtb-${local.vpc_context}-private"
  }
  nacl_default_tags = {
    Name = "network-acl-${local.vpc_context}-default"
  }
  nacl_public_tags = {
    Name = "network-acl-${local.vpc_context}-public"
  }
  nacl_private_tags = {
    Name = "network-acl-${local.vpc_context}-private"
  }
  tgw_attachment_tags = {
    Name = "tgw-attachment-vpc-${local.vpc_context}"
  }
  network_acls_wp = [
    {
      rule_number = 10
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "10.60.0.0/16"
    },
    {
      rule_number = 20
      rule_action = "deny"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "10.0.0.0/8"
    },
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_block  = "0.0.0.0/0"
    }
  ]

  db_subnet_group_name = "subnetgroup-rds-${local.vpc_context}"
}