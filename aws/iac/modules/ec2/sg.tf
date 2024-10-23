resource "aws_security_group" "sg" {
  name                   = local.sg_name
  description            = "Security Group da instancia EC2 ${local.instance_name}"
  vpc_id                 = data.aws_subnet.subnet.vpc_id
  revoke_rules_on_delete = true
  tags = {
    Name = local.sg_name
  }
}

resource "aws_security_group_rule" "ssh_sg_rule" {
  security_group_id = aws_security_group.sg.id
  description       = "Regra para permitir o acesso via SSH aos ranges privados da conta Shared"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks = concat(
    data.terraform_remote_state.shared.outputs.vpc_use1_private_subnets_cidr_blocks,
    data.terraform_remote_state.shared.outputs.vpc_sae1_private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "rdp_sg_rule" {
  count             = var.os == "windows" ? 1 : 0
  security_group_id = aws_security_group.sg.id
  description       = "Regra para permitir o acesso via RDP aos ranges privados da conta Shared"
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  cidr_blocks = concat(
    data.terraform_remote_state.shared.outputs.vpc_use1_private_subnets_cidr_blocks,
    data.terraform_remote_state.shared.outputs.vpc_sae1_private_subnets_cidr_blocks
  )
}

resource "aws_security_group_rule" "rdp_sg_anbima_rule" {
  count             = var.os == "windows" && var.allow_rdp == true ? 1 : 0
  security_group_id = aws_security_group.sg.id
  description       = "Regra para permitir o acesso via RDP aos ranges da ANBIMA"
  type              = "ingress"
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"
  prefix_list_ids   = var.rdp_sg_anbima_pl
}

resource "aws_security_group_rule" "prometheus_exporter_sg_rule" {
  count             = var.prometheus_exporter ? 1 : 0
  security_group_id = aws_security_group.sg.id
  description       = "Regra para permitir o acesso as metricas do Prometheus aos ranges privados da conta Shared"
  type              = "ingress"
  from_port         = 9100
  to_port           = 9100
  protocol          = "tcp"
  cidr_blocks = concat(
    data.terraform_remote_state.shared.outputs.vpc_use1_private_subnets_cidr_blocks,
    data.terraform_remote_state.shared.outputs.vpc_sae1_private_subnets_cidr_blocks
  )
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