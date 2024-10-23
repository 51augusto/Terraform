resource "aws_subnet" "databricks_network" {
  for_each          = local.databricks_subnets
  provider          = aws.use1
  vpc_id            = module.vpc_use1.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.az

  tags = {
    Name = local.databricks_subnet_name
  }
}

resource "aws_route_table_association" "databricks_subnet_to_private_rtb" {
  for_each       = aws_subnet.databricks_network
  provider       = aws.use1
  subnet_id      = each.value.id
  route_table_id = module.vpc_use1.intra_route_table_ids[0]
}