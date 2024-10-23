resource "aws_route" "vpc_egress_use1_private_rtb_sdwan" {
  provider               = aws.use1
  for_each               = toset(module.vpc_egress_use1.private_route_table_ids)
  route_table_id         = each.key
  destination_cidr_block = "10.180.100.0/24"
  network_interface_id   = data.terraform_remote_state.firewall.outputs.ftg_vm1_primary_use1_eni
  depends_on             = [module.vpc_egress_use1]
}

resource "aws_ec2_transit_gateway_route" "workloads_to_firewall_use1" {
  destination_cidr_block         = "10.180.100.0/24"
  provider                       = aws.use1
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_route" "vpc_egress_use1_private_rtb_sdwan_esc_rj" {
  provider               = aws.use1
  for_each               = toset(module.vpc_egress_use1.private_route_table_ids)
  route_table_id         = each.key
  destination_cidr_block = "10.120.0.0/16"
  network_interface_id   = data.terraform_remote_state.firewall.outputs.ftg_vm1_primary_use1_eni
  depends_on             = [module.vpc_egress_use1]
}

resource "aws_ec2_transit_gateway_route" "workloads_to_firewall_use1_esc_rj" {
  destination_cidr_block         = "10.120.0.0/16"
  provider                       = aws.use1
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_route" "vpc_egress_use1_private_rtb_sdwan_esc_sp" {
  provider               = aws.use1
  for_each               = toset(module.vpc_egress_use1.private_route_table_ids)
  route_table_id         = each.key
  destination_cidr_block = "10.100.0.0/16"
  network_interface_id   = data.terraform_remote_state.firewall.outputs.ftg_vm1_primary_use1_eni
  depends_on             = [module.vpc_egress_use1]
}

resource "aws_ec2_transit_gateway_route" "workloads_to_firewall_use1_esc_sp" {
  destination_cidr_block         = "10.100.0.0/16"
  provider                       = aws.use1
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}
resource "aws_route" "vpc_egress_use1_private_rtb_sdwan_dc_rede_10" {
  provider               = aws.use1
  for_each               = toset(module.vpc_egress_use1.private_route_table_ids)
  route_table_id         = each.key
  destination_cidr_block = "10.0.0.0/8"
  network_interface_id   = data.terraform_remote_state.firewall.outputs.ftg_vm1_primary_use1_eni
  depends_on             = [module.vpc_egress_use1]
}

resource "aws_ec2_transit_gateway_route" "workloads_to_firewall_use1_dc_rede_10" {
  destination_cidr_block         = "10.0.0.0/8"
  provider                       = aws.use1
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_route" "vpc_egress_use1_private_rtb_sdwan_dc_rede_198" {
  provider               = aws.use1
  for_each               = toset(module.vpc_egress_use1.private_route_table_ids)
  route_table_id         = each.key
  destination_cidr_block = "198.18.0.0/24"
  network_interface_id   = data.terraform_remote_state.firewall.outputs.ftg_vm1_primary_use1_eni
  depends_on             = [module.vpc_egress_use1]
}

resource "aws_ec2_transit_gateway_route" "workloads_to_firewall_use1_dc_rede_198" {
  destination_cidr_block         = "198.18.0.0/24"
  provider                       = aws.use1
  transit_gateway_attachment_id  = module.tgw_use1.ec2_transit_gateway_vpc_attachment_ids[0]
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.workloads_use1.id
}

resource "aws_route" "vpc_egress_use1_private_rtb_sdwan_workloads" {
  provider               = aws.use1
  for_each               = var.tgw_attachments_use1
  route_table_id         = module.vpc_egress_use1.private_route_table_ids[0]
  destination_cidr_block = each.value.cidr_block
  transit_gateway_id     = module.tgw_use1.ec2_transit_gateway_id
  depends_on             = [module.vpc_egress_use1]
}

resource "aws_route" "vpc_egress_use1_private_rtb_1_sdwan_workloads" {
  provider               = aws.use1
  for_each               = var.tgw_attachments_use1
  route_table_id         = module.vpc_egress_use1.private_route_table_ids[1]
  destination_cidr_block = each.value.cidr_block
  transit_gateway_id     = module.tgw_use1.ec2_transit_gateway_id
  depends_on             = [module.vpc_egress_use1]
}

resource "aws_route" "vpc_egress_use1_private_rtb_2_sdwan_workloads" {
  provider               = aws.use1
  for_each               = var.tgw_attachments_use1
  route_table_id         = module.vpc_egress_use1.private_route_table_ids[2]
  destination_cidr_block = each.value.cidr_block
  transit_gateway_id     = module.tgw_use1.ec2_transit_gateway_id
  depends_on             = [module.vpc_egress_use1]
}