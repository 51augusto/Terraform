# Ref: https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.6.4/components.yaml

resource "kubernetes_service_account" "metrics_server" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name      = "metrics-server"
    namespace = "kube-system"
    labels = {
      k8s-app = "metrics-server"
    }
  }
}

resource "kubernetes_cluster_role" "system_aggregated_metrics_reader" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name = "system:aggregated-metrics-reader"
    labels = {
      k8s-app                                        = "metrics-server"
      "rbac.authorization.k8s.io/aggregate-to-admin" = "true"
      "rbac.authorization.k8s.io/aggregate-to-edit"  = "true"
      "rbac.authorization.k8s.io/aggregate-to-view"  = "true"
    }
  }
  rule {
    verbs      = ["get", "list", "watch"]
    api_groups = ["metrics.k8s.io"]
    resources  = ["pods", "nodes"]
  }
}

resource "kubernetes_cluster_role" "system_metrics_server" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name = "system:metrics-server"
    labels = {
      k8s-app = "metrics-server"
    }
  }
  rule {
    verbs      = ["get"]
    api_groups = [""]
    resources  = ["nodes/metrics"]
  }
  rule {
    verbs      = ["get", "list", "watch"]
    api_groups = [""]
    resources  = ["pods", "nodes"]
  }
}

resource "kubernetes_role_binding" "metrics_server_auth_reader" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name      = "metrics-server-auth-reader"
    namespace = "kube-system"
    labels = {
      k8s-app = "metrics-server"
    }
  }
  subject {
    kind      = "ServiceAccount"
    name      = "metrics-server"
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = "extension-apiserver-authentication-reader"
  }
}

resource "kubernetes_cluster_role_binding" "metrics_server_system_auth_delegator" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name = "metrics-server:system:auth-delegator"
    labels = {
      k8s-app = "metrics-server"
    }
  }
  subject {
    kind      = "ServiceAccount"
    name      = "metrics-server"
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "system:auth-delegator"
  }
}

resource "kubernetes_cluster_role_binding" "system_metrics_server" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name = "system:metrics-server"
    labels = {
      k8s-app = "metrics-server"
    }
  }
  subject {
    kind      = "ServiceAccount"
    name      = "metrics-server"
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.system_metrics_server[0].metadata[0].name
  }
}

resource "kubernetes_service" "metrics_server" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name      = "metrics-server"
    namespace = "kube-system"
    labels = {
      k8s-app = "metrics-server"
    }
  }
  spec {
    port {
      name        = "https"
      protocol    = "TCP"
      port        = 443
      target_port = "https"
    }
    selector = {
      k8s-app = "metrics-server"
    }
  }
}

resource "kubernetes_deployment" "metrics_server" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name      = "metrics-server"
    namespace = "kube-system"
    labels = {
      k8s-app = "metrics-server"
    }
  }
  spec {
    replicas = 2
    selector {
      match_labels = {
        k8s-app = "metrics-server"
      }
    }
    template {
      metadata {
        labels = {
          k8s-app = "metrics-server"
        }
      }
      spec {
        volume {
          name = "tmp-dir"
          empty_dir {

          }
        }
        container {
          name              = "metrics-server"
          image             = "registry.k8s.io/metrics-server/metrics-server:v0.7.2"
          image_pull_policy = "IfNotPresent"
          args              = ["--cert-dir=/tmp", "--secure-port=4443", "--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname", "--kubelet-use-node-status-port", "--metric-resolution=15s"]
          port {
            name           = "https"
            container_port = 4443
            protocol       = "TCP"
          }
          resources {
            limits = {
              cpu    = "100m"
              memory = "100Mi"
            }
            requests = {
              cpu    = "50m"
              memory = "60Mi"
            }
          }
          volume_mount {
            name       = "tmp-dir"
            mount_path = "/tmp"
          }
          liveness_probe {
            http_get {
              path   = "/livez"
              port   = "https"
              scheme = "HTTPS"
            }
            period_seconds    = 10
            failure_threshold = 3
          }
          readiness_probe {
            http_get {
              path   = "/readyz"
              port   = "https"
              scheme = "HTTPS"
            }
            initial_delay_seconds = 20
            period_seconds        = 10
            failure_threshold     = 3
          }
          security_context {
            run_as_user               = 1000
            run_as_non_root           = true
            read_only_root_filesystem = true
          }
        }
        service_account_name = kubernetes_service_account.metrics_server[0].metadata[0].name
        priority_class_name  = "system-cluster-critical"
        node_selector = {
          "node/reserved-for" = "system"
        }
        toleration {
          key      = "CriticalAddonsOnly"
          operator = "Exists"
        }
      }
    }
  }
}

resource "kubernetes_api_service" "v1_beta1_metrics_k8s_io" {
  count = var.install_metrics_server ? 1 : 0
  metadata {
    name = "v1beta1.metrics.k8s.io"
    labels = {
      k8s-app = "metrics-server"
    }
  }
  spec {
    service {
      namespace = "kube-system"
      name      = "metrics-server"
    }
    group                    = "metrics.k8s.io"
    version                  = "v1beta1"
    insecure_skip_tls_verify = true
    group_priority_minimum   = 100
    version_priority         = 100
  }
}