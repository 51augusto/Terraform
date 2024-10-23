locals {
  eks_sa_role_name           = "role-eks-sa-app-${module.this.custom_context_id}"
  eks_sa_secrets_policy_name = "policy-eks-sa-app-secrets-${module.this.custom_context_id}"
  oidc_provider_name         = replace(var.oidc_provider_arn, "/^.*oidc-provider\\//", "")
  k8s_namespace              = "anbima-${var.area}-${var.app}"
  k8s_labels = merge({
    app         = var.app
    environment = var.environment
  }, var.labels)
}