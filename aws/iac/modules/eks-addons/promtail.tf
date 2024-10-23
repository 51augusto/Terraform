resource "helm_release" "promtail" {
  count      = var.install_promtail ? 1 : 0
  name       = "promtail"
  namespace  = kubernetes_namespace.kube_logging[0].metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "promtail"
  version    = "6.16.6"
  values     = [replace(file("${path.module}/helm_values/promtail.yaml"), "\r\n", "\n")]

  set {
    name  = "extraArgs"
    value = "{-client.external-labels=eks_cluster=${var.eks_cluster_name}\\,environment=${var.environment}}"
  }
}