resource "aws_security_group" "sg" {
  count                  = var.security_group_ids == null ? 1 : 0
  name                   = local.sg_name
  description            = "Security group do OpenSearch ${local.domain_name}"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  tags = {
    Name = local.sg_name
  }
}

resource "aws_security_group_rule" "default_egress_sg_rule" {
  count             = var.security_group_ids == null ? 1 : 0
  security_group_id = aws_security_group.sg[0].id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "default_ingress_sg_rule" {
  count             = var.security_group_ids == null ? 1 : 0
  security_group_id = aws_security_group.sg[0].id
  type              = "ingress"
  description       = "Liberacao de acesso a API do OpenSearch para o range de IPs da conta shared"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks = concat(
    data.terraform_remote_state.shared.outputs.vpc_use1_private_subnets_cidr_blocks,
    data.terraform_remote_state.shared.outputs.vpc_sae1_private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "internal_network" {
  count             = var.security_group_ids == null ? 1 : 0
  security_group_id = aws_security_group.sg[0].id
  description       = "Liberacao de acesso a API do OpenSearch para ranges de IP da rede interna da ANBIMA"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  prefix_list_ids   = [local.pl_ids]
}

resource "aws_security_group_rule" "sg_rule" {
  count             = var.security_group_ids == null ? length(var.inbound_rules) : 0
  security_group_id = aws_security_group.sg[0].id
  description       = var.inbound_rules[count.index].description
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = var.inbound_rules[count.index].cidr_blocks
}