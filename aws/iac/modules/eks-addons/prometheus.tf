locals {
  prometheus_config = merge({
    host           = null
    replicas       = 1
    storage        = "50Gi"
    retention      = "15d"
    retention_size = ""
  }, var.prometheus_config)
  alertmanager_config = merge({
    external = null  # Hostname do Alertmanager externo
    internal = false # Flag para habilitação do Alertmanager interno
    host     = null
    replicas = 1
    storage  = "20Gi"
  }, var.alertmanager_config)
  alertmanager_base_props = [
    {
      name  = "alertmanager.enabled"
      value = local.alertmanager_config.internal
      type  = "auto"
    }
  ]
  alertmanager_external_props = [
    {
      name  = "prometheus.prometheusSpec.additionalAlertManagerConfigs[0].scheme"
      value = "https"
      type  = "string"
    },
    {
      name  = "prometheus.prometheusSpec.additionalAlertManagerConfigs[0].static_configs[0].targets[0]"
      value = local.alertmanager_config.external
      type  = "string"
    }
  ]
  alertmanager_internal_props = [
    {
      name  = "alertmanager.alertmanagerSpec.replicas"
      value = local.alertmanager_config.replicas
      type  = "auto"
    },
    {
      name  = "alertmanager.alertmanagerSpec.storage.volumeClaimTemplate.spec.resources.requests.storage"
      value = local.alertmanager_config.storage
      type  = "string"
    }
  ]
  alertmanager_props = concat(
    local.alertmanager_base_props,
    local.alertmanager_config.external != null ? local.alertmanager_external_props : [],
    local.alertmanager_config.internal ? local.alertmanager_internal_props : []
  )
}

resource "helm_release" "prometheus" {
  count      = var.install_prometheus_stack ? 1 : 0
  name       = "prometheus"
  namespace  = kubernetes_namespace.kube_monitoring[0].metadata[0].name
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  version    = "65.3.2"
  values     = [replace(file("${path.module}/helm_values/prometheus.yaml"), "\r\n", "\n")]

  set {
    name  = "prometheusOperator.admissionWebhooks.caBundle"
    value = var.eks_cluster_ca_cert
    type  = "string"
  }

  set {
    name  = "prometheus.prometheusSpec.podMetadata.annotations.iam\\.amazonaws\\.com/role"
    value = aws_iam_role.prometheus[0].arn
    type  = "string"
  }

  set {
    name  = "prometheus.prometheusSpec.replicas"
    value = local.prometheus_config.replicas
    type  = "auto"
  }

  set {
    name  = "prometheus.prometheusSpec.storageSpec.volumeClaimTemplate.spec.resources.requests.storage"
    value = local.prometheus_config.storage
    type  = "string"
  }
  set {
    name  = "prometheus.prometheusSpec.externalUrl"
    value = "https://${local.prometheus_config.host}/"
    type  = "string"
  }

  set {
    name  = "prometheus.prometheusSpec.retention"
    value = local.prometheus_config.retention
    type  = "string"
  }

  set {
    name  = "prometheus.prometheusSpec.retentionSize"
    value = local.prometheus_config.retention_size
    type  = "string"
  }

  set {
    name  = "prometheus.prometheusSpec.externalLabels.cluster"
    value = var.eks_cluster_name
    type  = "string"
  }

  set {
    name  = "prometheus.prometheusSpec.additionalScrapeConfigs[0].ec2_sd_configs[0].region"
    value = var.eks_cluster_region
    type  = "string"
  }

  set {
    name  = "prometheus.prometheusSpec.additionalScrapeConfigs[0].ec2_sd_configs[0].filters[0].values[0]"
    value = var.eks_cluster_name
    type  = "string"
  }

  dynamic "set" {
    for_each = local.alertmanager_props

    content {
      name  = set.value.name
      value = set.value.value
      type  = set.value.type
    }
  }

  depends_on = [helm_release.ebs_csi_driver[0]]
}

resource "kubernetes_ingress_v1" "prometheus" {
  count = var.install_prometheus_stack && local.prometheus_config.host != null ? 1 : 0
  metadata {
    name      = "prometheus"
    namespace = kubernetes_namespace.kube_monitoring[0].metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                       = "alb"
      "alb.ingress.kubernetes.io/group.name"              = "internal"
      "alb.ingress.kubernetes.io/target-type"             = "ip"
      "alb.ingress.kubernetes.io/target-group-attributes" = "stickiness.enabled=true,stickiness.type=app_cookie,stickiness.app_cookie.cookie_name=grafana_session,stickiness.app_cookie.duration_seconds=43200"
      "alb.ingress.kubernetes.io/listen-ports"            = "[{\"HTTPS\": 443}]"
      "alb.ingress.kubernetes.io/healthcheck-path"        = "/-/ready"
      "alb.ingress.kubernetes.io/target-node-labels"      = "node/reserved-for=system"
    }
  }
  spec {
    rule {
      host = local.prometheus_config.host
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "prometheus-kube-prometheus-prometheus"
              port {
                number = 9090
              }
            }
          }
        }
      }
    }
  }
  depends_on = [helm_release.aws_lb_ingress[0]]
}

resource "kubernetes_ingress_v1" "alertmanager" {
  count = var.install_prometheus_stack && local.alertmanager_config.host != null ? 1 : 0
  metadata {
    name      = "alertmanager"
    namespace = kubernetes_namespace.kube_monitoring[0].metadata[0].name
    annotations = {
      "kubernetes.io/ingress.class"                  = "alb"
      "alb.ingress.kubernetes.io/group.name"         = "internal"
      "alb.ingress.kubernetes.io/target-type"        = "ip"
      "alb.ingress.kubernetes.io/listen-ports"       = "[{\"HTTPS\": 443}]"
      "alb.ingress.kubernetes.io/healthcheck-path"   = "/-/ready"
      "alb.ingress.kubernetes.io/target-node-labels" = "node/reserved-for=system"
    }
  }
  spec {
    rule {
      host = local.alertmanager_config.host
      http {
        path {
          path      = "/"
          path_type = "Prefix"
          backend {
            service {
              name = "prometheus-kube-prometheus-alertmanager"
              port {
                number = 9093
              }
            }
          }
        }
      }
    }
  }
  depends_on = [helm_release.aws_lb_ingress[0]]
}

resource "aws_iam_role" "prometheus" {
  count              = var.install_prometheus_stack ? 1 : 0
  name               = local.role_prometheus_name
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.assume_role_policy.json
  tags = merge(
    { Name = local.role_prometheus_name },
    var.tags
  )
}

data "aws_iam_policy_document" "prometheus_policy" {
  count = var.install_prometheus_stack ? 1 : 0
  statement {
    actions = [
      "ec2:DescribeInstances"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "prometheus" {
  count  = var.install_prometheus_stack ? 1 : 0
  name   = local.policy_prometheus_name
  path   = "/"
  policy = data.aws_iam_policy_document.prometheus_policy[0].json
  tags = merge(
    { Name = local.policy_prometheus_name },
    var.tags
  )
}

resource "aws_iam_role_policy_attachment" "prometheus" {
  count      = var.install_prometheus_stack ? 1 : 0
  role       = aws_iam_role.prometheus[0].name
  policy_arn = aws_iam_policy.prometheus[0].arn
}
