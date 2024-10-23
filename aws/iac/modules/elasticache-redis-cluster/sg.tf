resource "aws_security_group" "sg" {
  count                  = var.security_group_ids == null ? 1 : 0
  name                   = local.sg_name
  description            = "Security group do ElastiCache ${var.name}"
  vpc_id                 = var.vpc_id
  revoke_rules_on_delete = true

  tags = {
    Name = local.sg_name
  }
}

resource "aws_security_group_rule" "default_egress_sg_rule" {
  security_group_id = aws_security_group.sg[0].id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "sg_rule" {
  count             = var.security_group_ids == null ? length(var.inbound_rules) : 0
  security_group_id = aws_security_group.sg[0].id
  description       = var.inbound_rules[count.index].description
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  cidr_blocks       = var.inbound_rules[count.index].cidr_blocks
}

resource "aws_security_group_rule" "internal_network" {
  security_group_id = aws_security_group.sg[0].id
  description       = "Liberacao de acesso da porta de acesso ao ElastiCache para ranges de IP da rede interna da ANBIMA"
  type              = "ingress"
  from_port         = var.port
  to_port           = var.port
  protocol          = "tcp"
  prefix_list_ids   = concat(local.pl_ids)

}