resource "aws_eks_addon" "kube_proxy" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "kube-proxy"
  addon_version               = var.kube_proxy_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "coredns"
  addon_version               = var.coredns_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name                = var.eks_cluster_name
  addon_name                  = "vpc-cni"
  addon_version               = var.vpc_cni_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_iam_role" "efs_csi_driver" {
  count = var.install_efs_csi_driver ? 1 : 0
  name  = local.role_efs_csi_driver_name
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : var.eks_cluster_oidc_provider_arn
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringLike" : {
            "${local.oidc_prefix}:sub" : "system:serviceaccount:kube-system:efs-csi-*",
            "${local.oidc_prefix}:aud" : "sts.amazonaws.com"
          }
        }
      }
    ]
  })
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEFSCSIDriverPolicy"]
  tags                = merge({ Name = local.role_efs_csi_driver_name }, var.tags)
}

resource "aws_eks_addon" "efs_csi_driver" {
  count                       = var.install_efs_csi_driver ? 1 : 0
  cluster_name                = var.eks_cluster_name
  addon_name                  = "aws-efs-csi-driver"
  addon_version               = var.efs_csi_driver_version
  service_account_role_arn    = aws_iam_role.efs_csi_driver[0].arn
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "kubernetes_storage_class" "efs_storage_class" {
  count = var.install_efs_csi_driver ? 1 : 0
  metadata {
    name = "efs"
  }
  storage_provisioner = "efs.csi.aws.com"
}

# Verificar versões compatíveis com o cluster:
# aws eks describe-addon-versions --kubernetes-version 1.28 --addon-name kube-proxy --query 'addons[].addonVersions[].{Version: addonVersion, Defaultversion: compatibilities[0].defaultVersion}' --output table
# aws eks describe-addon-versions --kubernetes-version 1.28 --addon-name coredns --query 'addons[].addonVersions[].{Version: addonVersion, Defaultversion: compatibilities[0].defaultVersion}' --output table
# aws eks describe-addon-versions --kubernetes-version 1.28 --addon-name vpc-cni --query 'addons[].addonVersions[].{Version: addonVersion, Defaultversion: compatibilities[0].defaultVersion}' --output table
# aws eks describe-addon-versions --kubernetes-version 1.28 --addon-name aws-efs-csi-driver --query 'addons[].addonVersions[].{Version: addonVersion, Defaultversion: compatibilities[0].defaultVersion}' --output table
# vpc-cni precisa atualizar 1 minor version por vez