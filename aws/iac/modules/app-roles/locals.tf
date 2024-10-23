locals {
  ec2_role_name    = "role-ec2-${module.this.custom_context_id}"
  eks_role_name    = "role-eks-pod-${module.this.custom_context_id}"
  ecs_role_name    = "role-ecs-task-${module.this.custom_context_id}"
  cicd_role_name   = "role-cicd-${module.this.custom_context_id}"
  cicd_policy_name = "policy-cicd-eks-${module.this.custom_context_id}"
  ops_role_name    = "role-ops-${module.this.custom_context_id}"
  ops_policy_name  = "policy-ops-eks-${module.this.custom_context_id}"

  ops_start_stop_policy_name = "policy-ops-start-stop-${module.this.custom_context_id}"
}