resource "aws_iam_role" "eks_sa_role" {
  name        = local.eks_sa_role_name
  description = "Role para EKS Service Account da aplicação ${var.app}"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = var.oidc_provider_arn
        },
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "${local.oidc_provider_name}:aud" = "sts.amazonaws.com",
            "${local.oidc_provider_name}:sub" = "system:serviceaccount:${kubernetes_namespace_v1.namespace.metadata[0].name}:app"
          }
        }
      }
    ]
  })
  tags = {
    Name = local.eks_sa_role_name
  }
}

resource "aws_iam_policy" "eks_sa_secrets_policy" {
  count       = var.app_secrets_arns != null ? 1 : 0
  name        = local.eks_sa_secrets_policy_name
  description = "Política para acesso a secrets pela EKS Service Account da aplicação ${var.app}."
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "AllowSecret"
        Effect = "Allow",
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        Resource = var.app_secrets_arns
      }
    ]
  })
  tags = {
    Name = local.eks_sa_secrets_policy_name
  }
}

resource "aws_iam_role_policy_attachment" "eks_sa_secrets_policy_attachment" {
  count      = var.app_secrets_arns != null ? 1 : 0
  role       = aws_iam_role.eks_sa_role.name
  policy_arn = aws_iam_policy.eks_sa_secrets_policy[0].arn
}

resource "kubernetes_service_account_v1" "app" {
  metadata {
    name      = "app"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.eks_sa_role.arn
    }
  }
}

resource "kubernetes_role_v1" "app_role" {
  count = var.app_permission_rules != null ? 1 : 0
  metadata {
    name      = "app-role"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }
  dynamic "rule" {
    for_each = var.app_permission_rules
    content {
      api_groups = rule.value["api_groups"]
      verbs      = rule.value["verbs"]
      resources  = rule.value["resources"]
    }
  }
}

resource "kubernetes_role_binding_v1" "app_role_binding" {
  count = var.app_permission_rules != null ? 1 : 0
  metadata {
    name      = "app-role-binding"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account_v1.app.metadata[0].name
    namespace = local.k8s_namespace
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.app_role[0].metadata[0].name
  }
}
