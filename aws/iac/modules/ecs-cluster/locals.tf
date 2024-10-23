locals {
  cluster_name     = "ecs-${module.this.custom_context_id}"
  cicd_policy_name = "policy-cicd-${local.cluster_name}"
}