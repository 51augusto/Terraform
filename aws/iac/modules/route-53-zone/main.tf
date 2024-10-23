resource "aws_route53_zone" "ext" {
  count = var.public_zone ? 1 : 0
  name  = local.public_domain_name

  tags = {
    Name = local.public_domain_name
  }
}

resource "aws_route53_zone" "int" {
  count = var.private_zone ? 1 : 0
  name  = local.private_domain_name

  dynamic "vpc" {
    for_each = var.private_zone_vpc_ids
    content {
      vpc_id     = vpc.value.vpc_id
      vpc_region = vpc.value.region
    }
  }

  tags = {
    Name = local.private_domain_name
  }
}