module "eks" {
  source                                         = "git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/eks-cluster-hashicorp.git?ref=main"
  cluster_endpoint_private_access                = true
  cluster_endpoint_public_access                 = false
  cluster_create_endpoint_private_access_sg_rule = true
  cluster_endpoint_private_access_cidrs          = ["10.0.0.0/8"]
  cluster_name                                   = local.cluster_name
  cluster_version                                = var.k8s_version
  vpc_id                                         = var.vpc_id
  subnets                                        = var.private_subnets_ids
  cluster_encryption_config = [
    {
      provider_key_arn = aws_kms_key.this.arn
      resources        = ["secrets"]
    }
  ]
  workers_additional_policies = concat(
    [aws_iam_policy.worker_policy.arn],
    local.workers_aws_policies,
    local.workers_custom_policies
  )
  cluster_enabled_log_types     = var.cluster_enabled_log_types
  cluster_log_retention_in_days = var.cluster_log_retention_in_days
  wait_for_cluster_timeout      = var.wait_for_cluster_timeout
  enable_irsa                   = true
  workers_role_name             = "role-${local.cluster_name}-workers"
  cluster_iam_role_name         = "role-${local.cluster_name}"
  workers_group_defaults = {
    key_name          = local.key_name
    enable_monitoring = var.node_groups_enable_monitoring
  }
  node_groups_defaults = local.node_groups_defaults
  node_groups          = local.node_groups_config
  map_roles            = var.roles_aws_auth
  map_users            = var.users_aws_auth
  map_accounts         = var.accounts_aws_auth
  write_kubeconfig     = false
  cluster_tags = {
    Name = local.cluster_name
  }
  tags = var.tags
}

resource "aws_security_group_rule" "ssh_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  description       = "SSH access"
  cidr_blocks       = [data.aws_vpc.main.cidr_block]
  security_group_id = module.eks.worker_security_group_id
}

resource "aws_iam_policy" "worker_policy" {
  name   = "policy-${module.eks.cluster_id}-workers-assume-role"
  path   = "/"
  policy = data.aws_iam_policy_document.worker_policy.json
  tags = merge({
    Name = "policy-${module.eks.cluster_id}-workers-assume-role"
  }, var.tags)
}

resource "random_string" "system_suffix" {
  length  = 8
  special = false
  keepers = {
    force_update = var.system_node_group_force_update
  }
}

resource "aws_kms_key" "this" {
  description             = "Chave KMS para o cluster EKS ${local.cluster_name}"
  enable_key_rotation     = true
  deletion_window_in_days = 30
  tags = merge({
    Name = "kms-key-${local.cluster_name}"
  }, var.tags)
}

resource "aws_kms_alias" "this" {
  name          = "alias/kms-key-${local.cluster_name}"
  target_key_id = aws_kms_key.this.key_id
}
