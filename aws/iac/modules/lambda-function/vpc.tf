resource "aws_security_group" "sg" {
  count                  = local.create_sg ? 1 : 0
  name                   = local.sg_name
  description            = "Security group da funcao Lambda ${local.function_name}"
  vpc_id                 = var.vpc_config.vpc_id
  revoke_rules_on_delete = true
  tags = {
    Name = local.sg_name
  }
}

resource "aws_security_group_rule" "default_egress_sg_rule" {
  count             = local.create_sg ? 1 : 0
  security_group_id = aws_security_group.sg[0].id
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}
