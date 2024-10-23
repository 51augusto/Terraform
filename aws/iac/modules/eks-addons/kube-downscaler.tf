resource "kubernetes_config_map" "kube_downscaler" {
  count = var.install_kubedownscaler ? 1 : 0
  metadata {
    name      = "kube-downscaler"
    namespace = "kube-system"
  }
}

resource "kubernetes_service_account" "kube_downscaler" {
  count = var.install_kubedownscaler ? 1 : 0
  metadata {
    name      = "kube-downscaler"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role" "kube_downscaler" {
  count = var.install_kubedownscaler ? 1 : 0
  metadata {
    name = "kube-downscaler"
  }

  rule {
    verbs      = ["get", "watch", "list"]
    api_groups = [""]
    resources  = ["pods", "namespaces"]
  }

  rule {
    verbs      = ["get", "watch", "list", "update", "patch"]
    api_groups = ["apps"]
    resources  = ["deployments", "statefulsets"]
  }

  rule {
    verbs      = ["get", "watch", "list", "update", "patch"]
    api_groups = ["argoproj.io"]
    resources  = ["rollouts"]
  }

  rule {
    verbs      = ["get", "watch", "list", "update", "patch"]
    api_groups = ["autoscaling"]
    resources  = ["horizontalpodautoscalers"]
  }

  rule {
    verbs      = ["get", "watch", "list", "update", "patch"]
    api_groups = ["batch"]
    resources  = ["cronjobs"]
  }

  rule {
    verbs      = ["get", "watch", "list", "update", "patch"]
    api_groups = ["keda.sh"]
    resources  = ["scaledobjects"]
  }

  rule {
    verbs      = ["get", "watch", "list", "update", "patch"]
    api_groups = ["zalando.org"]
    resources  = ["stacks"]
  }

  rule {
    verbs      = ["get", "create", "watch", "list", "update", "patch"]
    api_groups = [""]
    resources  = ["events"]
  }
}

resource "kubernetes_cluster_role_binding" "kube_downscaler" {
  count = var.install_kubedownscaler ? 1 : 0
  metadata {
    name = "kube-downscaler"
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.kube_downscaler[0].metadata[0].name
    namespace = "kube-system"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.kube_downscaler[0].metadata[0].name
  }
}

resource "kubernetes_deployment" "kube_downscaler" {
  count = var.install_kubedownscaler ? 1 : 0
  metadata {
    name      = "kube-downscaler"
    namespace = "kube-system"

    labels = {
      application = "kube-downscaler"

      version = "v23.2.0"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        application = "kube-downscaler"
      }
    }

    template {
      metadata {
        labels = {
          application = "kube-downscaler"

          version = "v23.2.0"
        }
      }

      spec {
        container {
          name  = "downscaler"
          image = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/kube-downscaler:23.2.0"
          args  = ["--interval=60"]

          env_from {
            config_map_ref {
              name     = "kube-downscaler"
              optional = true
            }
          }

          resources {
            limits = {
              cpu    = "200m"
              memory = "400Mi"
            }

            requests = {
              cpu    = "100m"
              memory = "200Mi"
            }
          }

          security_context {
            run_as_user               = 1000
            run_as_non_root           = true
            read_only_root_filesystem = true
          }
        }

        service_account_name = kubernetes_service_account.kube_downscaler[0].metadata[0].name
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

