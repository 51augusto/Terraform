resource "aws_customer_gateway" "sae1" {
  provider    = aws.sae1
  device_name = module.this_sae1["shared"].customer_gw_id
  bgp_asn     = 65400
  ip_address  = "200.183.45.30"
  type        = "ipsec.1"
  tags        = module.this_sae1["shared"].customer_gw_tags
}

resource "aws_vpn_connection" "sae1" {
  provider            = aws.sae1
  customer_gateway_id = aws_customer_gateway.sae1.id
  transit_gateway_id  = module.tgw_sae1.ec2_transit_gateway_id
  type                = aws_customer_gateway.sae1.type
  static_routes_only  = false
  tags                = module.this_sae1["shared"].vpn_connection_tags
}

##############################
# TAGS TGW ATTACHMENT VPN 
##############################

resource "aws_ec2_tag" "vpn_attachment_name_sae1" {
  provider    = aws.sae1
  resource_id = aws_vpn_connection.sae1.transit_gateway_attachment_id
  key         = "Name"
  value       = module.this_sae1["shared"].tgw_attachment_vpn_id
}

resource "aws_ec2_tag" "vpn_attachment_map_migrated_sae1" {
  provider    = aws.sae1
  resource_id = aws_vpn_connection.sae1.transit_gateway_attachment_id
  key         = "map-migrated"
  value       = var.tags["map-migrated"]
}

resource "aws_ec2_tag" "vpn_attachment_iac_sae1" {
  provider    = aws.sae1
  resource_id = aws_vpn_connection.sae1.transit_gateway_attachment_id
  key         = "IAC"
  value       = "true"
}

resource "aws_ec2_tag" "vpn_attachment_environment_sae1" {
  provider    = aws.sae1
  resource_id = aws_vpn_connection.sae1.transit_gateway_attachment_id
  key         = "Environment"
  value       = module.this_sae1["shared"].custom_context.stage
}