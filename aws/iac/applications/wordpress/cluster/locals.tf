locals {
  cluster_name    = "ecs-${module.this.custom_context_id}"
  alb_name        = "alb-ecs-${module.this.custom_context_id}"
  alb_sg_name     = "SG-${local.alb_name}"
  log_group_name  = "/aws/containerinsights/${local.cluster_name}/application"
  master_username = jsondecode(data.aws_secretsmanager_secret_version.db_root_credentials.secret_string)["username"]
  master_password = jsondecode(data.aws_secretsmanager_secret_version.db_root_credentials.secret_string)["password"]
}