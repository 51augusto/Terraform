resource "aws_route53_resolver_rule_association" "outbound_rule_association_use1" {
  provider         = aws.use1
  resolver_rule_id = data.terraform_remote_state.shared.outputs.resolver_rule_use1
  vpc_id           = module.vpc_use1.vpc_id
}

resource "aws_route53_resolver_rule_association" "outbound_rule_association_sae1" {
  provider         = aws.sae1
  resolver_rule_id = data.terraform_remote_state.shared.outputs.resolver_rule_sae1
  vpc_id           = module.vpc_sae1.vpc_id
}

resource "aws_route53_resolver_rule_association" "outbound_rule_association_cloud_use1" {
  provider         = aws.use1
  resolver_rule_id = data.terraform_remote_state.shared.outputs.resolver_rule_cloud_use1
  vpc_id           = module.vpc_use1.vpc_id
}

resource "aws_route53_resolver_rule_association" "outbound_rule_association_cloud_sae1" {
  provider         = aws.sae1
  resolver_rule_id = data.terraform_remote_state.shared.outputs.resolver_rule_cloud_sae1
  vpc_id           = module.vpc_sae1.vpc_id
}