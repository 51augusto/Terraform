data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    key            = "terraform/terraform.tfstate"
    bucket         = "s3-terraform-backend-network-use1-tfstate"
    dynamodb_table = "dynamo-terraform-backend-network-use1-tfstate"
    region         = "us-east-1"
    profile        = "network"
  }
}

data "aws_route53_resolver_endpoint" "indound_use1" {
  provider             = aws.use1
  resolver_endpoint_id = aws_route53_resolver_endpoint.inbound_endpoint_use1.id
}

data "aws_route53_resolver_endpoint" "outbound_use1" {
  provider             = aws.use1
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint_use1.id
}

data "aws_route53_resolver_endpoint" "indound_sae1" {
  provider             = aws.sae1
  resolver_endpoint_id = aws_route53_resolver_endpoint.inbound_endpoint_sae1.id
}

data "aws_route53_resolver_endpoint" "outbound_sae1" {
  provider             = aws.sae1
  resolver_endpoint_id = aws_route53_resolver_endpoint.outbound_endpoint_sae1.id
}

data "aws_network_interfaces" "r53_resolver_enis_use1" {
  provider = aws.use1
  filter {
    name   = "addresses.private-ip-address"
    values = local.r53_resolver_endpoints_ips_use1
  }
}

data "aws_network_interfaces" "r53_resolver_enis_sae1" {
  provider = aws.sae1
  filter {
    name   = "addresses.private-ip-address"
    values = local.r53_resolver_endpoints_ips_sae1
  }
}