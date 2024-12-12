resource "aws_iam_role" "ebs_csi_driver" {
  count               = var.install_ebs_csi_driver ? 1 : 0
  name                = local.role_ebs_csi_driver_name
  path                = "/"
  assume_role_policy  = data.aws_iam_policy_document.assume_role_policy.json
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"]
  tags = merge(
    { Name = local.role_ebs_csi_driver_name },
    var.tags
  )
}

resource "helm_release" "ebs_csi_driver" {
  count      = var.install_ebs_csi_driver ? 1 : 0
  name       = "ebs-csi-driver"
  namespace  = "kube-system"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
  version    = "2.38.1"
  values     = [replace(file("${path.module}/helm_values/ebs_csi_driver.yaml"), "\r\n", "\n")]

  set {
    name  = "controller.podAnnotations.iam\\.amazonaws\\.com/role"
    value = aws_iam_role.ebs_csi_driver[0].arn
    type  = "string"
  }

  set {
    name  = "node.podAnnotations.iam\\.amazonaws\\.com/role"
    value = aws_iam_role.ebs_csi_driver[0].arn
    type  = "string"
  }

  depends_on = [helm_release.kube2iam[0], aws_iam_role.ebs_csi_driver[0]]
}

resource "kubernetes_storage_class" "ebs_storage_class" {
  count = var.install_ebs_csi_driver ? 1 : 0
  metadata {
    name = "gp3"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
  reclaim_policy      = "Delete"
  parameters = {
    encrypted          = "true"
    type               = "gp3"
    tagSpecification_1 = "Name=eks-{{ .PVName }}"
  }
}