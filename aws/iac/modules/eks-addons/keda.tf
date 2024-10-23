resource "aws_iam_role" "keda" {
  count              = var.install_keda ? 1 : 0
  name               = local.role_keda_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = merge(
    { Name = local.role_keda_name },
  var.tags)
}

data "aws_iam_policy_document" "keda_policy" {
  count = var.install_keda ? 1 : 0
  statement {
    actions = [
      "sqs:GetQueueAttributes",
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "keda" {
  count  = var.install_keda ? 1 : 0
  name   = local.policy_keda_name
  path   = "/"
  policy = data.aws_iam_policy_document.keda_policy[0].json
  tags = merge(
    { Name = local.policy_keda_name },
  var.tags)
}

resource "aws_iam_role_policy_attachment" "keda" {
  count      = var.install_keda ? 1 : 0
  role       = aws_iam_role.keda[0].name
  policy_arn = aws_iam_policy.keda[0].arn
}

resource "helm_release" "keda" {
  count      = var.install_keda ? 1 : 0
  name       = "keda"
  namespace  = kubernetes_namespace.kube_keda[0].metadata[0].name
  repository = "https://kedacore.github.io/charts"
  chart      = "keda"
  version    = "2.15.2"
  values     = [replace(file("${path.module}/helm_values/keda.yaml"), "\r\n", "\n")]

  set {
    name  = "podAnnotations.keda.iam\\.amazonaws\\.com/role"
    value = aws_iam_role.keda[0].arn
    type  = "string"
  }
}