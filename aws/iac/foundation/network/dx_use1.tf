resource "aws_dx_gateway_association" "tgw_use1" {
  provider              = aws.use1
  allowed_prefixes      = local.dx_gateway_aws_routes_use1
  associated_gateway_id = module.tgw_use1.ec2_transit_gateway_id
  dx_gateway_id         = aws_dx_gateway.sae1.id
}

#################################
# TAGS TGW ATTACHMENT DX GATEWAY 
#################################

resource "aws_ec2_tag" "dx_attachment_name_use1" {
  provider    = aws.use1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.use1.id
  key         = "Name"
  value       = module.this_use1["shared"].tgw_attachment_dx_id
}

resource "aws_ec2_tag" "dx_attachment_map_migrated_use1" {
  provider    = aws.use1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.use1.id
  key         = "map-migrated"
  value       = var.tags["map-migrated"]
}

resource "aws_ec2_tag" "dx_attachment_iac_use1" {
  provider    = aws.use1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.use1.id
  key         = "IAC"
  value       = "true"
}

resource "aws_ec2_tag" "dx_attachment_environment_use1" {
  provider    = aws.use1
  resource_id = data.aws_ec2_transit_gateway_dx_gateway_attachment.use1.id
  key         = "Environment"
  value       = module.this_use1["shared"].custom_context.stage
}