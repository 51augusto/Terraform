locals {
  key_name = "ec2-key-internal-${var.environment}-${module.this.custom_context.environment}-linux"
  workers_group_defaults = {
    key_name                             = ""
    enable_monitoring                    = true
    subnets                              = []
    instance_type                        = "t3.large"
    cpu_credits                          = "standard"
    asg_desired_capacity                 = "1"
    asg_max_size                         = "3"
    asg_min_size                         = "1"
    launch_template_id                   = null
    launch_template_version              = "$Latest"
    metadata_http_endpoint               = "enabled"
    metadata_http_tokens                 = "optional"
    metadata_http_put_response_hop_limit = null
    root_kms_key_id                      = ""
    root_encrypted                       = false
    root_volume_size                     = "30"
    root_volume_type                     = "gp3"
    root_iops                            = "0"
    root_volume_throughput               = null
    timeouts                             = {}
    additional_security_group_ids        = []
    pre_userdata                         = ""
    kubelet_extra_args                   = ""
    eni_delete                           = true
    public_ip                            = false
  }
  node_group_name     = "nodes-${var.node_group_suffix_name}"
  node_group_aws_name = "eks-ng-${module.this.custom_context_id}-${local.node_group_name}-${random_string.suffix.result}"
  node_groups_defaults = {
    create_launch_template        = true
    ami_type                      = "AL2_x86_64"
    capacity_type                 = var.capacity_type
    desired_capacity              = var.desired_capacity
    instance_types                = var.instance_types
    cpu_credits                   = var.cpu_credits
    key_name                      = local.key_name
    launch_template_id            = null
    launch_template_version       = var.launch_template_version
    set_instance_types_on_lt      = false
    max_capacity                  = var.max_capacity
    min_capacity                  = var.min_capacity
    subnets                       = var.private_subnets_ids
    bootstrap_env                 = {}
    kubelet_extra_args            = ""
    disk_size                     = var.disk_size
    disk_type                     = "gp3"
    disk_iops                     = "0"
    disk_throughput               = null
    disk_encrypted                = true
    disk_kms_key_id               = "arn:${data.aws_partition.current.partition}:kms:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:alias/aws/ebs"
    enable_monitoring             = var.enable_monitoring
    eni_delete                    = true
    public_ip                     = false
    version                       = var.k8s_version
    pre_userdata                  = ""
    additional_security_group_ids = []
    k8s_labels = {
      "node_name"         = local.node_group_name
      "node/reserved-for" = var.node_group_suffix_name
    }
    taints = [
      {
        key    = "node/reserved-for"
        value  = var.node_group_suffix_name
        effect = "NO_SCHEDULE"
      }
    ]
    timeouts                             = {}
    update_default_version               = true
    ebs_optimized                        = null
    metadata_http_endpoint               = "enabled"
    metadata_http_tokens                 = "optional"
    metadata_http_put_response_hop_limit = null
    ami_is_eks_optimized                 = true
    update_config = {
      max_unavailable = var.max_unavailable
    }
    additional_tags = {
      "Name"                                              = local.node_group_aws_name
      "OS"                                                = "linux"
      "k8s.io/cluster-autoscaler/${var.eks_cluster_name}" = "owned"
      "k8s.io/cluster-autoscaler/enabled"                 = "TRUE"
    }
  }
  node_groups = {
    (var.node_group_suffix_name) = {
      name = local.node_group_aws_name
    }
  }
  ebs_optimized_not_supported = [
    "c1.medium",
    "c3.8xlarge",
    "c3.large",
    "c5d.12xlarge",
    "c5d.24xlarge",
    "c5d.metal",
    "cc2.8xlarge",
    "cr1.8xlarge",
    "g2.8xlarge",
    "g4dn.metal",
    "hs1.8xlarge",
    "i2.8xlarge",
    "m1.medium",
    "m1.small",
    "m2.xlarge",
    "m3.large",
    "m3.medium",
    "m5ad.16xlarge",
    "m5ad.8xlarge",
    "m5dn.metal",
    "m5n.metal",
    "r3.8xlarge",
    "r3.large",
    "r5ad.16xlarge",
    "r5ad.8xlarge",
    "r5dn.metal",
    "r5n.metal",
    "t1.micro",
    "t2.2xlarge",
    "t2.large",
    "t2.medium",
    "t2.micro",
    "t2.nano",
    "t2.small",
    "t2.xlarge"
  ]
}
