data "aws_organizations_organization" "org" {
  provider = aws.use1
}

data "aws_region" "use1" {
  provider = aws.use1
}

data "aws_ec2_transit_gateway_dx_gateway_attachment" "sae1" {
  provider           = aws.sae1
  transit_gateway_id = module.tgw_sae1.ec2_transit_gateway_id
  dx_gateway_id      = aws_dx_gateway.sae1.id
  # depends_on         = [aws_dx_gateway_association.tgw_sae1]
}

data "aws_ec2_transit_gateway_dx_gateway_attachment" "use1" {
  provider           = aws.use1
  transit_gateway_id = module.tgw_use1.ec2_transit_gateway_id
  dx_gateway_id      = aws_dx_gateway.sae1.id
  # depends_on         = [aws_dx_gateway_association.tgw_use1]
}

data "terraform_remote_state" "shared" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-shared-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-shared-use1-tfstate"
    region         = "us-east-1"
    profile        = "shared-services"
  }
}

data "terraform_remote_state" "firewall" {
  backend = "s3"
  config = {
    key            = "firewall/terraform.tfstate"
    bucket         = "s3-terraform-backend-network-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-network-use1-tfstate"
    region         = "us-east-1"
    profile        = "network"
  }
}
