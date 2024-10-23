resource "aws_iam_role" "cluster_autoscaler" {
  count              = var.install_cluster_autoscaler ? 1 : 0
  name               = local.role_cluster_autoscaler_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = merge(
    { Name = local.role_cluster_autoscaler_name },
  var.tags)
}

data "aws_iam_policy_document" "cluster_autoscaler_policy" {
  count = var.install_cluster_autoscaler ? 1 : 0
  statement {
    actions = [
      "autoscaling:DescribeAutoScalingGroups",
      "autoscaling:DescribeAutoScalingInstances",
      "autoscaling:DescribeLaunchConfigurations",
      "autoscaling:DescribeTags",
      "autoscaling:SetDesiredCapacity",
      "autoscaling:TerminateInstanceInAutoScalingGroup",
      "ec2:DescribeLaunchTemplateVersions"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "cluster_autoscaler" {
  count  = var.install_cluster_autoscaler ? 1 : 0
  name   = local.policy_cluster_autoscaler_name
  path   = "/"
  policy = data.aws_iam_policy_document.cluster_autoscaler_policy[0].json
  tags = merge(
    { Name = local.policy_cluster_autoscaler_name },
  var.tags)
}

resource "aws_iam_role_policy_attachment" "cluster_autoscaler" {
  count      = var.install_cluster_autoscaler ? 1 : 0
  role       = aws_iam_role.cluster_autoscaler[0].name
  policy_arn = aws_iam_policy.cluster_autoscaler[0].arn
}

resource "helm_release" "cluster_autoscaler" {
  count      = var.install_cluster_autoscaler ? 1 : 0
  depends_on = [helm_release.kube2iam[0], aws_iam_role_policy_attachment.cluster_autoscaler[0]]
  name       = "cluster-autoscaler"
  namespace  = "kube-system"
  repository = "https://kubernetes.github.io/autoscaler"
  chart      = "cluster-autoscaler"
  version    = "9.33.0"
  values     = [replace(file("${path.module}/helm_values/cluster_autoscaler.yaml"), "\r\n", "\n")]

  set {
    name  = "awsRegion"
    value = var.eks_cluster_region
  }

  set {
    name  = "autoDiscovery.clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "podAnnotations.iam\\.amazonaws\\.com/role"
    value = aws_iam_role.cluster_autoscaler[0].arn
    type  = "string"
  }
}