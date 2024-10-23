locals {
  cluster_name = "eks-cluster-${module.this.custom_context_id}"
  key_name     = "ec2-key-internal-${var.environment}-${module.this.custom_context.environment}-linux"
  node_groups_defaults = {
    create_launch_template = true
    ami_type               = "AL2_x86_64"
    disk_size              = var.node_groups_disk_size
    disk_type              = "gp3"
    disk_encrypted         = true
    disk_kms_key_id        = "arn:${data.aws_partition.current.partition}:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alias/aws/ebs"
    version                = var.ng_system_k8s_version
    update_config = {
      max_unavailable = var.max_unavailable
    }
  }
  workers_aws_policies = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore",
    "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  ]
  workers_custom_policies = [
    "arn:aws:iam::${data.aws_caller_identity.current.account_id}:policy/policy-s3-internal-${var.environment}-${module.this.custom_context.environment}-ssm-resources"
  ]
  node_group_aws_name = "eks-ng-${module.this.custom_context_id}-nodes-system-${random_string.system_suffix.result}"
  node_groups_config = {
    "system" = {
      name                    = local.node_group_aws_name
      desired_capacity        = lookup(var.system_node_group_config, "desired_capacity", 1)
      max_capacity            = lookup(var.system_node_group_config, "max_capacity", 10)
      min_capacity            = lookup(var.system_node_group_config, "min_capacity", 3)
      instance_types          = lookup(var.system_node_group_config, "instance_types", ["t3.large"])
      capacity_type           = lookup(var.system_node_group_config, "capacity_type", "ON_DEMAND")
      launch_template_version = lookup(var.system_node_group_config, "launch_template_version", "$Latest")
      k8s_labels = {
        "node_name"         = "nodes-system"
        "node/reserved-for" = "system"
      }
      taints = [
        {
          key    = "CriticalAddonsOnly"
          value  = "true"
          effect = "NO_SCHEDULE"
        }
      ]
      additional_tags = {
        "Name"                                            = local.node_group_aws_name
        "OS"                                              = "linux"
        "k8s.io/cluster-autoscaler/${local.cluster_name}" = "owned"
        "k8s.io/cluster-autoscaler/enabled"               = "TRUE"
      }
    }
  }
}