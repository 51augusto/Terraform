resource "aws_dx_gateway" "sae1" {
  provider        = aws.sae1
  amazon_side_asn = "64513"
  name            = module.this_sae1["shared"].dx_gateway_id
}

resource "aws_dx_transit_virtual_interface" "sae1_sp" {
  provider       = aws.sae1
  address_family = "ipv4"
  bgp_asn        = 65158
  connection_id  = "dxcon-fh7763ck"
  dx_gateway_id  = aws_dx_gateway.sae1.id
  mtu            = 1500
  name           = "${module.this_sae1["shared"].dx_vif_transit_id}-sp"
  tags           = { Name = "${module.this_sae1["shared"].dx_vif_transit_id}-sp" }
  vlan           = 1305
  timeouts {}
}

resource "aws_dx_transit_virtual_interface" "sae1_rj" {
  provider       = aws.sae1
  address_family = "ipv4"
  bgp_asn        = 65158
  connection_id  = "dxcon-fga2hy8l"
  dx_gateway_id  = aws_dx_gateway.sae1.id
  mtu            = 1500
  name           = "${module.this_sae1["shared"].dx_vif_transit_id}-rj"
  tags           = { Name = "${module.this_sae1["shared"].dx_vif_transit_id}-rj" }
  vlan           = 316
  timeouts {}
}

resource "aws_dx_gateway_association" "tgw_sae1" {
  provider              = aws.sae1
  allowed_prefixes      = local.dx_gateway_aws_routes_sae1
  associated_gateway_id = module.tgw_sae1.ec2_transit_gateway_id
  dx_gateway_id         = aws_dx_gateway.sae1.id
}

#################################
# TAGS TGW ATTACHMENT DX GATEWAY 
#################################

resource "aws_ec2_tag" "dx_attachment_name_sae1" {
  provider    = aws.sae1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.sae1.id
  key         = "Name"
  value       = module.this_sae1["shared"].tgw_attachment_dx_id
}

resource "aws_ec2_tag" "dx_attachment_map_migrated_sae1" {
  provider    = aws.sae1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.sae1.id
  key         = "map-migrated"
  value       = var.tags["map-migrated"]
}

resource "aws_ec2_tag" "dx_attachment_iac_sae1" {
  provider    = aws.sae1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.sae1.id
  key         = "IAC"
  value       = "true"
}

resource "aws_ec2_tag" "dx_attachment_environment_sae1" {
  provider    = aws.sae1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.sae1.id
  key         = "Environment"
  value       = module.this_sae1["shared"].custom_context.stage
}