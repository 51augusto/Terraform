resource "aws_customer_gateway" "use1" {
  provider    = aws.use1
  device_name = module.this_use1["shared"].customer_gw_id
  bgp_asn     = 65400
  ip_address  = "189.16.110.126"
  type        = "ipsec.1"
  tags        = module.this_use1["shared"].customer_gw_tags
}

resource "aws_vpn_connection" "use1" {
  provider            = aws.use1
  customer_gateway_id = aws_customer_gateway.use1.id
  transit_gateway_id  = module.tgw_use1.ec2_transit_gateway_id
  type                = aws_customer_gateway.use1.type
  static_routes_only  = false
  tags                = module.this_use1["shared"].vpn_connection_tags
}

##############################
# TAGS TGW ATTACHMENT VPN 
##############################

resource "aws_ec2_tag" "vpn_attachment_name_use1" {
  provider    = aws.use1
  resource_id = aws_vpn_connection.use1.transit_gateway_attachment_id
  key         = "Name"
  value       = module.this_use1["shared"].tgw_attachment_vpn_id
}

resource "aws_ec2_tag" "vpn_attachment_map_migrated_use1" {
  provider    = aws.use1
  resource_id = aws_vpn_connection.use1.transit_gateway_attachment_id
  key         = "map-migrated"
  value       = var.tags["map-migrated"]
}

resource "aws_ec2_tag" "vpn_attachment_iac_use1" {
  provider    = aws.use1
  resource_id = aws_vpn_connection.use1.transit_gateway_attachment_id
  key         = "IAC"
  value       = "true"
}

resource "aws_ec2_tag" "vpn_attachment_environment_use1" {
  provider    = aws.use1
  resource_id = aws_vpn_connection.use1.transit_gateway_attachment_id
  key         = "Environment"
  value       = module.this_use1["shared"].custom_context.stage
}