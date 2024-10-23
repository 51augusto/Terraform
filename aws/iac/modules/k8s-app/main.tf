resource "kubernetes_namespace_v1" "namespace" {
  metadata {
    name   = local.k8s_namespace
    labels = local.k8s_labels
  }
  lifecycle {
    ignore_changes = [
      metadata[0].annotations
    ]
  }
}

resource "kubernetes_resource_quota_v1" "compute_quota" {
  metadata {
    name      = "compute-quota"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }
  spec {
    hard = {
      "limits.cpu"      = var.quota.cpu.limit
      "limits.memory"   = var.quota.memory.limit
      "requests.cpu"    = var.quota.cpu.request
      "requests.memory" = var.quota.memory.request
    }
    scopes = ["NotTerminating"]
  }
}

resource "kubernetes_resource_quota_v1" "storage_quota" {
  metadata {
    name      = "storage-quota"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }
  spec {
    hard = {
      "requests.storage" = var.quota.storage
    }
  }
}

resource "kubernetes_limit_range_v1" "container_default_resources" {
  metadata {
    name      = "container-default-resources"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }
  spec {
    limit {
      type = "Container"
      default = {
        cpu    = var.container_default_resources.cpu.limit
        memory = var.container_default_resources.memory.limit
      }
      default_request = {
        cpu    = var.container_default_resources.cpu.request
        memory = var.container_default_resources.memory.request
      }
    }
  }
}