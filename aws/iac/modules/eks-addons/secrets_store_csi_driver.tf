resource "helm_release" "secrets_store_csi_driver" {
  count      = var.install_secrets_store_csi_driver ? 1 : 0
  name       = "secrets-store-csi-driver"
  repository = "https://kubernetes-sigs.github.io/secrets-store-csi-driver/charts"
  chart      = "secrets-store-csi-driver"
  version    = "1.4.6"
  timeout    = 600
  namespace  = "kube-system"
  values     = [replace(file("${path.module}/helm_values/secrets_store_csi_driver.yaml"), "\r\n", "\n")]
}

# Ref: https://github.com/aws/secrets-store-csi-driver-provider-aws/blob/r2/deployment/aws-provider-installer.yaml

resource "kubernetes_service_account" "secrets_store_csi_provider_aws" {
  count = var.install_secrets_store_csi_driver ? 1 : 0
  metadata {
    name      = "secrets-store-csi-provider-aws"
    namespace = "kube-system"
  }
}

resource "kubernetes_cluster_role" "secrets_store_csi_provider_aws_cluster_role" {
  count = var.install_secrets_store_csi_driver ? 1 : 0
  metadata {
    name = "secrets-store-csi-provider-aws-cluster-role"
  }
  rule {
    verbs      = ["create"]
    api_groups = [""]
    resources  = ["serviceaccounts/token"]
  }
  rule {
    verbs      = ["get"]
    api_groups = [""]
    resources  = ["serviceaccounts"]
  }
  rule {
    verbs      = ["get"]
    api_groups = [""]
    resources  = ["pods"]
  }
  rule {
    verbs      = ["get"]
    api_groups = [""]
    resources  = ["nodes"]
  }
}

resource "kubernetes_cluster_role_binding" "secrets_store_csi_provider_aws_cluster_rolebinding" {
  count = var.install_secrets_store_csi_driver ? 1 : 0
  metadata {
    name = "secrets-store-csi-provider-aws-cluster-rolebinding"
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.secrets_store_csi_provider_aws[0].metadata[0].name
    namespace = "kube-system"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.secrets_store_csi_provider_aws_cluster_role[0].metadata[0].name
  }
}

resource "kubernetes_daemonset" "secrets_store_csi_provider_aws" {
  count = var.install_secrets_store_csi_driver ? 1 : 0
  metadata {
    name      = "secrets-store-csi-provider-aws"
    namespace = "kube-system"
    labels = {
      app = "secrets-store-csi-provider-aws"
    }
  }
  spec {
    selector {
      match_labels = {
        app = "secrets-store-csi-provider-aws"
      }
    }
    template {
      metadata {
        labels = {
          app = "secrets-store-csi-provider-aws"
        }
      }
      spec {
        volume {
          name = "providervol"
          host_path {
            path = "/etc/kubernetes/secrets-store-csi-providers"
          }
        }
        volume {
          name = "mountpoint-dir"
          host_path {
            path = "/var/lib/kubelet/pods"
            type = "DirectoryOrCreate"
          }
        }
        container {
          name  = "provider-aws-installer"
          image = "public.ecr.aws/aws-secrets-manager/secrets-store-csi-driver-provider-aws:1.0.r2-56-g41fa54f-2023.11.15.21.38-linux-amd64"
          args  = ["--provider-volume=/etc/kubernetes/secrets-store-csi-providers"]
          resources {
            limits = {
              cpu    = "100m"
              memory = "100Mi"
            }
            requests = {
              cpu    = "10m"
              memory = "20Mi"
            }
          }
          volume_mount {
            name       = "providervol"
            mount_path = "/etc/kubernetes/secrets-store-csi-providers"
          }
          volume_mount {
            name              = "mountpoint-dir"
            mount_path        = "/var/lib/kubelet/pods"
            mount_propagation = "HostToContainer"
          }
          image_pull_policy = "Always"
        }
        node_selector = {
          "kubernetes.io/os" = "linux"
        }
        toleration {
          operator = "Exists"
        }
        service_account_name = kubernetes_service_account.secrets_store_csi_provider_aws[0].metadata[0].name
        host_network         = true
      }
    }
    strategy {
      type = "RollingUpdate"
    }
  }
}
