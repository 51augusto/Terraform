############################################
# REDE DE FW USE1 - HEARTBEAT  
############################################

resource "aws_subnet" "fw_heartbeat_use1" {
  for_each          = local.fw_use1_heartbeat_subnets
  provider          = aws.use1
  vpc_id            = module.vpc_egress_use1.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = local.fw_use1_heartbeat_subnet_name
  }
}

resource "aws_route_table" "fw_heartbeat_use1" {
  provider = aws.use1
  vpc_id   = module.vpc_egress_use1.vpc_id

  tags = {
    Name = local.fw_use1_heartbeat_rtb_name
  }
}

resource "aws_route_table_association" "fw_heartbeat_use1" {
  for_each       = aws_subnet.fw_heartbeat_use1
  provider       = aws.use1
  subnet_id      = each.value.id
  route_table_id = aws_route_table.fw_heartbeat_use1.id
}

############################################
# REDE DE FW USE1 - MGMT  
############################################

resource "aws_subnet" "fw_mgmt_use1" {
  for_each          = local.fw_use1_mgmt_subnets
  provider          = aws.use1
  vpc_id            = module.vpc_egress_use1.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = local.fw_use1_mgmt_subnet_name
  }
}

resource "aws_route_table_association" "fw_mgmt1_subnet_to_private_az_a_use1" {
  provider       = aws.use1
  subnet_id      = aws_subnet.fw_mgmt_use1["az1"].id
  route_table_id = module.vpc_egress_use1.private_route_table_ids[0]
}

resource "aws_route_table_association" "fw_mgmt2_subnet_to_private_az_b_use1" {
  provider       = aws.use1
  subnet_id      = aws_subnet.fw_mgmt_use1["az2"].id
  route_table_id = module.vpc_egress_use1.private_route_table_ids[1]
}