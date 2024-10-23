resource "aws_ec2_managed_prefix_list" "anbima_cidrs_use1" {
  provider       = aws.use1
  name           = "pl-vpc-${module.this_use1["shared"].custom_context_id}-rede-anbima"
  address_family = "IPv4"
  max_entries    = 5

  entry {
    cidr        = "10.100.100.0/23"
    description = "ANBIMA - Cabeada SP"
  }

  entry {
    cidr        = "10.100.150.0/23"
    description = "ANBIMA - Wi-Fi SP"
  }

  entry {
    cidr        = "10.120.100.0/24"
    description = "ANBIMA - Cabeada RJ"
  }

  entry {
    cidr        = "10.120.150.0/24"
    description = "ANBIMA - Wi-Fi RJ"
  }

  entry {
    cidr        = "10.180.0.0/16"
    description = "ANBIMA - VPN"
  }
}

resource "aws_ram_resource_share" "anbima_cidrs_use1" {
  provider                  = aws.use1
  name                      = "ram-${module.this_use1["shared"].custom_context_id}-anbima-cidr-pl"
  allow_external_principals = true
}

resource "aws_ram_resource_association" "anbima_cidrs_use1" {
  provider           = aws.use1
  resource_arn       = aws_ec2_managed_prefix_list.anbima_cidrs_use1.arn
  resource_share_arn = aws_ram_resource_share.anbima_cidrs_use1.arn
}

resource "aws_ram_principal_association" "anbima_cidrs_use1" {
  provider           = aws.use1
  principal          = data.aws_organizations_organization.org.arn
  resource_share_arn = aws_ram_resource_share.anbima_cidrs_use1.arn
}

resource "aws_ec2_managed_prefix_list" "anbima_dc_cidrs_use1" {
  provider       = aws.use1
  name           = "pl-vpc-${module.this_use1["shared"].custom_context_id}-rede-anbima-dc"
  address_family = "IPv4"
  max_entries    = 3

  entry {
    cidr        = "10.150.0.0/16"
    description = "ANBIMA - Novo DC"
  }

  entry {
    cidr        = "10.225.66.0/24"
    description = "ANBIMA - Legado SP"
  }

  entry {
    cidr        = "10.32.17.0/24"
    description = "ANBIMA - Legado RJ"
  }
}

resource "aws_ram_resource_share" "anbima_dc_cidrs_use1" {
  provider                  = aws.use1
  name                      = "ram-${module.this_use1["shared"].custom_context_id}-anbima-dc-cidr-pl"
  allow_external_principals = true
}

resource "aws_ram_resource_association" "anbima_dc_cidrs_use1" {
  provider           = aws.use1
  resource_arn       = aws_ec2_managed_prefix_list.anbima_dc_cidrs_use1.arn
  resource_share_arn = aws_ram_resource_share.anbima_dc_cidrs_use1.arn
}

resource "aws_ram_principal_association" "anbima_dc_cidrs_use1" {
  provider           = aws.use1
  principal          = data.aws_organizations_organization.org.arn
  resource_share_arn = aws_ram_resource_share.anbima_dc_cidrs_use1.arn
}