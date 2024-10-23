resource "kubernetes_ingress_v1" "aws_lb_ingress_internal" {
  count = var.install_ingress_controller_internal ? 1 : 0
  metadata {
    name      = "aws-lb-controller-internal"
    namespace = kubernetes_namespace.kube_ingress[0].metadata[0].name
    annotations = {
      "alb.ingress.kubernetes.io/group.name"                          = "internal"
      "alb.ingress.kubernetes.io/load-balancer-name"                  = local.alb_ingress_internal_name
      "alb.ingress.kubernetes.io/security-groups"                     = aws_security_group.alb_ingress_internal[0].id
      "alb.ingress.kubernetes.io/manage-backend-security-group-rules" = "true"
      "alb.ingress.kubernetes.io/listen-ports"                        = "[{\"HTTP\": 80},{\"HTTPS\": 443}]"
      "alb.ingress.kubernetes.io/scheme"                              = "internal"
      "alb.ingress.kubernetes.io/ssl-redirect"                        = "443"
      "alb.ingress.kubernetes.io/ssl-policy"                          = local.internal_alb_config.ssl_policy
      "alb.ingress.kubernetes.io/tags"                                = "Environment=${var.environment},IAC=true,map-migated=d-server-01oiau1h5afqhv"
      "alb.ingress.kubernetes.io/target-type"                         = "instance"
      "alb.ingress.kubernetes.io/load-balancer-attributes"            = join(",", local.alb_ingress_internal_lb_attributes)
      "alb.ingress.kubernetes.io/certificate-arn"                     = join(",", [local.internal_alb_config.acm_certificate_arn, local.external_alb_config.acm_certificate_arn])
      "alb.ingress.kubernetes.io/wafv2-acl-arn"                       = local.internal_alb_config.waf_acl_arn
      "alb.ingress.kubernetes.io/healthcheck-path"                    = "/error.html"
      "kubernetes.io/ingress.class"                                   = "alb"
    }
  }
  spec {
    default_backend {
      service {
        name = kubernetes_service.aws_lb_ingress_internal[0].metadata[0].name
        port {
          number = 8080
        }
      }
    }
    rule {
      host = "${local.alb_ingress_internal_default_backend}.${local.internal_alb_config.domain}"
      http {
        path {
          path = "/"
          backend {
            service {
              name = kubernetes_service.aws_lb_ingress_internal[0].metadata[0].name
              port {
                number = 8080
              }
            }
          }
        }
      }
    }
  }
  depends_on = [helm_release.aws_lb_ingress[0]]
}

resource "kubernetes_service" "aws_lb_ingress_internal" {
  count = var.install_ingress_controller_internal ? 1 : 0
  metadata {
    name      = local.alb_ingress_internal_default_backend
    namespace = kubernetes_namespace.kube_ingress[0].metadata[0].name
  }
  spec {
    port {
      name     = local.alb_ingress_internal_default_backend
      protocol = "TCP"
      port     = 8080
    }
    selector = {
      app = local.alb_ingress_default_backend_deployment
    }
    type = "NodePort"
  }
}

resource "aws_security_group" "alb_ingress_internal" {
  count  = var.install_ingress_controller_internal ? 1 : 0
  name   = local.alb_ingress_internal_sg_name
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = local.internal_alb_config.cidr_blocks
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = local.internal_alb_config.cidr_blocks
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = merge(
    { Name = local.alb_ingress_internal_sg_name },
    var.tags
  )
}