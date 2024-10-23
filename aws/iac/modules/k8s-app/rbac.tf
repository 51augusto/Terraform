resource "kubernetes_role_v1" "ro_role" {
  metadata {
    name      = "ro-role"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  rule {
    api_groups = ["", "extensions", "apps", "batch", "autoscaling", "networking.k8s.io"]
    verbs      = ["get", "list", "watch"]
    resources  = ["configmaps", "cronjobs", "deployments", "events", "ingresses", "jobs", "pods", "pods/log", "services", "namespaces"]
  }
}

resource "kubernetes_role_binding_v1" "ro_role_binding" {
  metadata {
    name      = "ro-role-binding"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "${var.app}_ro"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.ro_role.metadata[0].name
  }
}

resource "kubernetes_role_v1" "editor_role" {
  metadata {
    name      = "editor-role"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  rule {
    api_groups = ["", "extensions", "apps", "batch", "autoscaling"]
    verbs      = ["get", "list", "watch", "create", "update", "patch", "delete"]
    resources  = ["configmaps", "cronjobs", "deployments", "events", "jobs", "pods", "pods/attach", "pods/exec", "pods/log", "pods/portforward"]
  }

  rule {
    api_groups = ["", "extensions", "apps", "autoscaling", "networking.k8s.io"]
    verbs      = ["get", "list", "watch", "create"]
    resources  = ["ingresses", "services"]
  }

  rule {
    api_groups = [""]
    verbs      = ["get", "list", "watch"]
    resources  = ["namespaces"]
  }
}

resource "kubernetes_role_binding_v1" "editor_role_binding" {
  metadata {
    name      = "editor-role-binding"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "${var.app}_editor"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.editor_role.metadata[0].name
  }
}

resource "kubernetes_role_v1" "cicd_role" {
  metadata {
    name      = "cicd-role"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  dynamic "rule" {
    for_each = var.cicd_permission_rules
    content {
      api_groups = rule.value["api_groups"]
      verbs      = rule.value["verbs"]
      resources  = rule.value["resources"]
    }
  }
}

resource "kubernetes_role_binding_v1" "cicd_role_binding" {
  metadata {
    name      = "cicd-role-binding"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "cicd_${var.app}"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.cicd_role.metadata[0].name
  }
}

resource "kubernetes_role_v1" "ops_role" {
  metadata {
    name      = "ops-role"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  dynamic "rule" {
    for_each = var.ops_permission_rules
    content {
      api_groups = rule.value["api_groups"]
      verbs      = rule.value["verbs"]
      resources  = rule.value["resources"]
    }
  }
}

resource "kubernetes_role_binding_v1" "ops_role_binding" {
  metadata {
    name      = "ops-role-binding"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
    labels    = local.k8s_labels
  }

  subject {
    api_group = "rbac.authorization.k8s.io"
    kind      = "User"
    name      = "ops_${var.app}"
    namespace = kubernetes_namespace_v1.namespace.metadata[0].name
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role_v1.ops_role.metadata[0].name
  }
}
