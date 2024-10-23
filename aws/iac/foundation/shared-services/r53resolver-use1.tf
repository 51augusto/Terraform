resource "aws_security_group" "outbound_endpoint_use1" {
  provider = aws.use1
  name     = "SG-r53-${module.this_use1.custom_context_id}-resolver"
  vpc_id   = module.vpc_use1.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Toda a rede da Anbima"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  ingress {
    description = "Toda a rede da Anbima"
    from_port   = 53
    to_port     = 53
    protocol    = "udp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  tags = {
    Name = "SG-r53-${module.this_use1.custom_context_id}-resolver"
  }
}

resource "aws_route53_resolver_endpoint" "outbound_endpoint_use1" {
  provider  = aws.use1
  name      = "resolver-r53-${module.this_use1.custom_context_id}-outbound"
  direction = "OUTBOUND"
  security_group_ids = [
    aws_security_group.outbound_endpoint_use1.id
  ]

  ip_address {
    subnet_id = module.vpc_use1.intra_subnets[0]
  }

  ip_address {
    subnet_id = module.vpc_use1.intra_subnets[2]

  }
}

resource "aws_route53_resolver_rule" "outbound_rule_use1" {
  provider             = aws.use1
  domain_name          = "anbima.com.int"
  name                 = "rule-r53-${module.this_use1.custom_context_id}-outbound"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint_use1.id

  target_ip {
    ip = var.aws_ad_ip
  }

  target_ip {
    ip = var.on_premisses_ad_ip
  }

  tags = {
    name = "rule-r53-${module.this_use1.custom_context_id}-outbound"
  }
}

resource "aws_ram_resource_share" "ram_outbound_resolver_use1" {
  provider                  = aws.use1
  name                      = "ram-${module.this_use1.custom_context_id}-resolver"
  allow_external_principals = false
  tags = {
    name = "ram-${module.this_use1.custom_context_id}-resolver"
  }
}

resource "aws_ram_resource_association" "ram_outbound_resolver_use1" {
  provider           = aws.use1
  resource_arn       = aws_route53_resolver_rule.outbound_rule_use1.arn
  resource_share_arn = aws_ram_resource_share.ram_outbound_resolver_use1.arn
}

data "aws_organizations_organization" "this_use1" {
  provider = aws.use1
}

resource "aws_ram_principal_association" "ram_outbound_resolver_use1" {
  provider           = aws.use1
  principal          = data.aws_organizations_organization.this_use1.arn
  resource_share_arn = aws_ram_resource_share.ram_outbound_resolver_use1.arn
}

resource "aws_route53_resolver_rule_association" "outbound_rule_association_use1" {
  provider         = aws.use1
  resolver_rule_id = aws_route53_resolver_rule.outbound_rule_use1.id
  vpc_id           = module.vpc_use1.vpc_id
}

resource "aws_route53_resolver_rule" "outbound_rule_galgo_use1" {
  provider             = aws.use1
  domain_name          = "sistemagalgo"
  name                 = "rule-r53-${module.this_use1.custom_context_id}-galgo-outbound"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint_use1.id

  target_ip {
    ip = var.rtm_dns1_ip
  }

  target_ip {
    ip = var.rtm_dns2_ip
  }

  tags = {
    name = "rule-r53-${module.this_use1.custom_context_id}-galgo-outbound"
  }
}

resource "aws_ram_resource_share" "ram_outbound_resolver_galgo_use1" {
  provider                  = aws.use1
  name                      = "ram-${module.this_use1.custom_context_id}-galgo-resolver"
  allow_external_principals = false
  tags = {
    name = "ram-${module.this_use1.custom_context_id}-galgo-resolver"
  }
}

resource "aws_ram_resource_association" "ram_outbound_resolver_galgo_use1" {
  provider           = aws.use1
  resource_arn       = aws_route53_resolver_rule.outbound_rule_galgo_use1.arn
  resource_share_arn = aws_ram_resource_share.ram_outbound_resolver_galgo_use1.arn
}

data "aws_organizations_organization" "this_galgo_use1" {
  provider = aws.use1
}

resource "aws_ram_principal_association" "ram_outbound_resolver_galgo_use1" {
  provider           = aws.use1
  principal          = data.aws_organizations_organization.this_galgo_use1.arn
  resource_share_arn = aws_ram_resource_share.ram_outbound_resolver_galgo_use1.arn
}

resource "aws_route53_resolver_rule_association" "outbound_rule_association_galgo_use1" {
  provider         = aws.use1
  resolver_rule_id = aws_route53_resolver_rule.outbound_rule_galgo_use1.id
  vpc_id           = module.vpc_use1.vpc_id
}

resource "aws_route53_resolver_rule" "outbound_rule_cloud_use1" {
  provider             = aws.use1
  domain_name          = "anbima.cloud"
  name                 = "rule-r53-${module.this_use1.custom_context_id}-cloud-outbound"
  rule_type            = "FORWARD"
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint_use1.id

  target_ip {
    ip = element(aws_route53_resolver_endpoint.inbound_endpoint_use1.ip_address[*].ip, 0)
  }

  target_ip {
    ip = element(aws_route53_resolver_endpoint.inbound_endpoint_use1.ip_address[*].ip, 1)
  }

  tags = {
    name = "rule-r53-${module.this_use1.custom_context_id}-cloud-outbound"
  }
}

resource "aws_ram_resource_share" "ram_outbound_resolver_cloud_use1" {
  provider                  = aws.use1
  name                      = "ram-${module.this_use1.custom_context_id}-cloud-resolver"
  allow_external_principals = false

  tags = {
    name = "ram-${module.this_use1.custom_context_id}-cloud-resolver"
  }
}

resource "aws_ram_resource_association" "ram_outbound_resolver_cloud_use1" {
  provider           = aws.use1
  resource_arn       = aws_route53_resolver_rule.outbound_rule_cloud_use1.arn
  resource_share_arn = aws_ram_resource_share.ram_outbound_resolver_cloud_use1.arn
}

data "aws_organizations_organization" "this_cloud_use1" {
  provider = aws.use1
}

resource "aws_ram_principal_association" "ram_outbound_resolver_cloud_use1" {
  provider           = aws.use1
  principal          = data.aws_organizations_organization.this_cloud_use1.arn
  resource_share_arn = aws_ram_resource_share.ram_outbound_resolver_cloud_use1.arn
}

resource "aws_route53_resolver_endpoint" "inbound_endpoint_use1" {
  provider  = aws.use1
  name      = "resolver-r53-${module.this_use1.custom_context_id}-inbound"
  direction = "INBOUND"
  security_group_ids = [
    aws_security_group.outbound_endpoint_use1.id
  ]

  ip_address {
    subnet_id = module.vpc_use1.intra_subnets[0]
  }

  ip_address {
    subnet_id = module.vpc_use1.intra_subnets[2]

  }
}