locals {
  install_ingress_controller = var.install_ingress_controller_external || var.install_ingress_controller_internal

  alb_ingress_default_name  = "alb-${replace(var.eks_cluster_name, "cluster-", "")}"
  alb_ingress_external_name = "${local.alb_ingress_default_name}-external"
  alb_ingress_internal_name = "${local.alb_ingress_default_name}-internal"

  alb_ingress_sg_default       = "SG-${local.alb_ingress_default_name}"
  alb_ingress_external_sg_name = "${local.alb_ingress_sg_default}-external"
  alb_ingress_internal_sg_name = "${local.alb_ingress_sg_default}-internal"

  external_alb_config = merge({
    domain              = "",
    acm_certificate_arn = "",
    waf_acl_arn         = "",
    timeout             = 600,
    access_logs_bucket  = null,
    cidr_blocks         = ["0.0.0.0/0"],
    ssl_policy          = "ELBSecurityPolicy-TLS-1-2-2017-01"
  }, var.external_alb_config)

  internal_alb_config = merge({
    domain              = "",
    acm_certificate_arn = "",
    waf_acl_arn         = "",
    timeout             = 600,
    access_logs_bucket  = null,
    cidr_blocks         = ["0.0.0.0/0"],
    ssl_policy          = "ELBSecurityPolicy-TLS-1-2-2017-01"
  }, var.internal_alb_config)

  alb_ingress_external_lb_attrs_timeout = ["idle_timeout.timeout_seconds=${local.external_alb_config.timeout}"]
  alb_ingress_external_lb_attrs_access_logs = local.external_alb_config.access_logs_bucket == null ? ["access_logs.s3.enabled=false"] : [
    "access_logs.s3.enabled=true",
    "access_logs.s3.bucket=${local.external_alb_config.access_logs_bucket}",
    "access_logs.s3.prefix=${local.alb_ingress_external_name}"
  ]

  alb_ingress_external_lb_attributes = concat(
    local.alb_ingress_external_lb_attrs_timeout,
    local.alb_ingress_external_lb_attrs_access_logs
  )

  alb_ingress_internal_lb_attrs_timeout = ["idle_timeout.timeout_seconds=${local.internal_alb_config.timeout}"]
  alb_ingress_internal_lb_attrs_access_logs = local.internal_alb_config.access_logs_bucket == null ? ["access_logs.s3.enabled=false"] : [
    "access_logs.s3.enabled=true",
    "access_logs.s3.bucket=${local.internal_alb_config.access_logs_bucket}",
    "access_logs.s3.prefix=${local.alb_ingress_internal_name}"
  ]

  alb_ingress_internal_lb_attributes = concat(
    local.alb_ingress_internal_lb_attrs_timeout,
    local.alb_ingress_internal_lb_attrs_access_logs
  )

  alb_ingress_default_backend_deployment = "default-backend"
  alb_ingress_external_default_backend   = "default-backend-external"
  alb_ingress_internal_default_backend   = "default-backend-internal"
}

resource "helm_release" "aws_lb_ingress" {
  count      = local.install_ingress_controller ? 1 : 0
  name       = "aws-lb-controller"
  namespace  = kubernetes_namespace.kube_ingress[0].metadata[0].name
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.10.1"
  values     = [replace(file("${path.module}/helm_values/lb_ingress.yaml"), "\r\n", "\n")]

  set {
    name  = "clusterName"
    value = var.eks_cluster_name
  }

  set {
    name  = "fullnameOverride"
    value = "aws-load-balance-controller"
  }

  set {
    name  = "podAnnotations.iam\\.amazonaws\\.com/role"
    value = aws_iam_role.aws_lb_ingress[0].arn
    type  = "string"
  }

  depends_on = [helm_release.kube2iam[0], aws_iam_role_policy_attachment.aws_lb_ingress[0]]
}

resource "kubernetes_deployment" "aws_lb_ingress_default_backend" {
  count = local.install_ingress_controller ? 1 : 0
  metadata {
    name      = local.alb_ingress_default_backend_deployment
    namespace = kubernetes_namespace.kube_ingress[0].metadata[0].name
    labels = {
      app = local.alb_ingress_default_backend_deployment
    }
  }

  spec {
    replicas = 2
    selector {
      match_labels = {
        app = local.alb_ingress_default_backend_deployment
      }
    }
    template {
      metadata {
        labels = {
          app = local.alb_ingress_default_backend_deployment
        }
      }
      spec {
        node_selector = {
          "node/reserved-for" = "system"
        }
        container {
          name  = local.alb_ingress_default_backend_deployment
          image = var.default_backend_image
          port {
            name           = local.alb_ingress_default_backend_deployment
            container_port = 8080
          }
          env {
            name  = "HTTP_PORT"
            value = "8080"
          }
          env {
            name  = "HTTPS_PORT"
            value = "8443"
          }
          resources {
            limits = {
              cpu    = "100m"
              memory = "100Mi"
            }
            requests = {
              cpu    = "100m"
              memory = "100Mi"
            }
          }
        }
        toleration {
          operator = "Exists"
          key      = "CriticalAddonsOnly"
        }
        restart_policy = "Always"
      }
    }
    strategy {
      type = "RollingUpdate"
      rolling_update {
        max_unavailable = "25%"
        max_surge       = "25%"
      }
    }
  }
}