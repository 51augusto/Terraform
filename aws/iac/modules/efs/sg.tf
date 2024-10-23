resource "aws_security_group" "sg" {
  name        = local.sg_name
  description = "Security Group do EFS ${local.efs_fs_name}"
  vpc_id      = var.vpc_id
  tags = {
    Name = local.sg_name
  }
}

resource "aws_security_group_rule" "shared_account_rule" {
  security_group_id = aws_security_group.sg.id
  description       = "Regra para permitir o acesso aos ranges privados da conta Shared"
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks = concat(
    data.terraform_remote_state.shared.outputs.vpc_use1_private_subnets_cidr_blocks,
    data.terraform_remote_state.shared.outputs.vpc_sae1_private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "cidr_blocks_rule" {
  count = var.ingress_cidr_blocks != null ? 1 : 0

  security_group_id = aws_security_group.sg.id
  type              = "ingress"
  from_port         = 2049
  to_port           = 2049
  protocol          = "tcp"
  cidr_blocks       = var.ingress_cidr_blocks
}

resource "aws_security_group_rule" "egress_sg_rule" {
  security_group_id = aws_security_group.sg.id
  description       = "Regra de egress padrao"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["0.0.0.0/0"]
}