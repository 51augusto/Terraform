resource "kubernetes_namespace" "kube_monitoring" {
  count = var.install_prometheus_stack ? 1 : 0
  metadata {
    name = "kube-monitoring"
    labels = {
      name = "kube-monitoring"
    }
  }
}

resource "kubernetes_namespace" "kube_logging" {
  count = var.install_promtail ? 1 : 0
  metadata {
    name = "kube-logging"
    labels = {
      name = "kube-logging"
    }
  }
}

resource "kubernetes_namespace" "kube_ingress" {
  count = local.install_ingress_controller ? 1 : 0
  metadata {
    name = "kube-ingress"
    labels = {
      name = "kube-ingress"
    }
  }
}

resource "kubernetes_namespace" "kube_keda" {
  count = var.install_keda ? 1 : 0
  metadata {
    name = "kube-keda"
    labels = {
      name = "kube-keda"
    }
  }
}