resource "helm_release" "kube2iam" {
  count      = var.install_kube2iam ? 1 : 0
  name       = "kube2iam"
  namespace  = "kube-system"
  repository = "https://jtblin.github.io/kube2iam/"
  chart      = "kube2iam"
  version    = "2.6.0"
  values     = [replace(file("${path.module}/helm_values/kube2iam.yaml"), "\r\n", "\n")]
}