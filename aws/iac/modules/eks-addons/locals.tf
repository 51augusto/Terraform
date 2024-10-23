locals {
  oidc_prefix = replace(data.aws_iam_openid_connect_provider.eks.url, "https://", "")

  role_default_name            = "role-eks-addon"
  role_efs_csi_driver_name     = "${local.role_default_name}-efs-csi-driver-${var.eks_cluster_name}"
  role_ebs_csi_driver_name     = "${local.role_default_name}-ebs-csi-driver-${var.eks_cluster_name}"
  role_lb_ingress_name         = "${local.role_default_name}-aws-lb-ingress-${var.eks_cluster_name}"
  role_prometheus_name         = "${local.role_default_name}-prometheus-${var.eks_cluster_name}"
  role_cluster_autoscaler_name = length(local.cluster_autoscaler_name) >= 64 ? replace(local.cluster_autoscaler_name, "eks-cluster-", "") : local.cluster_autoscaler_name
  role_keda_name               = "${local.role_default_name}-keda-${var.eks_cluster_name}"

  policy_default_name            = "policy-eks-addon"
  policy_lb_ingress_name         = "${local.policy_default_name}-aws-lb-ingress-${var.eks_cluster_name}"
  policy_prometheus_name         = "${local.policy_default_name}-prometheus-${var.eks_cluster_name}"
  policy_cluster_autoscaler_name = "${local.policy_default_name}-cluster-autoscaler-${var.eks_cluster_name}"
  policy_keda_name               = "${local.policy_default_name}-keda-${var.eks_cluster_name}"

  cluster_autoscaler_name = "${local.role_default_name}-cluster-autoscaler-${var.eks_cluster_name}"
}