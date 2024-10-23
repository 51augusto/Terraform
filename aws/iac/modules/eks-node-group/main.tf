module "eks_node_group" {
  source                      = "git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/eks-cluster-hashicorp.git//modules/node_groups?ref=main"
  cluster_name                = var.eks_cluster_name
  cluster_endpoint            = var.eks_cluster_endpoint
  cluster_auth_base64         = var.eks_cluster_ca_cert
  default_iam_role_arn        = var.worker_iam_role_arn
  ebs_optimized_not_supported = local.ebs_optimized_not_supported
  workers_group_defaults      = local.workers_group_defaults
  node_groups_defaults        = local.node_groups_defaults
  node_groups                 = local.node_groups
  worker_security_group_id    = var.worker_security_group_id
  tags                        = var.tags

}

resource "random_string" "suffix" {
  length  = 8
  special = false
  keepers = {
    force_update = var.node_group_force_update
  }
}

resource "aws_autoscaling_group_tag" "asg_tag_label" {
  autoscaling_group_name = module.eks_node_group.node_groups[var.node_group_suffix_name].resources[0].autoscaling_groups[0].name
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/label/node/reserved-for"
    value               = var.node_group_suffix_name
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_group_tag" "asg_tag_taint" {
  autoscaling_group_name = module.eks_node_group.node_groups[var.node_group_suffix_name].resources[0].autoscaling_groups[0].name
  tag {
    key                 = "k8s.io/cluster-autoscaler/node-template/taint/node/reserved-for"
    value               = "${var.node_group_suffix_name}:NoSchedule"
    propagate_at_launch = true
  }
}
