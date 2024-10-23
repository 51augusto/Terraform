module "ecs" {
  source       = "terraform-aws-modules/ecs/aws"
  version      = "5.11.4"
  cluster_name = local.cluster_name
  cluster_settings = {
    name  = "containerInsights"
    value = "disabled"
  }
  default_capacity_provider_use_fargate = true
  fargate_capacity_providers = {
    FARGATE = {
      default_capacity_provider_strategy = {
        base   = 1
        weight = 100
      }
    }
  }
  tags = {
    Name = local.cluster_name
  }
  create_cloudwatch_log_group = false
}

resource "aws_cloudwatch_log_group" "log_group" {
  name              = local.log_group_name
  retention_in_days = 30
  tags = {
    Name = local.log_group_name
  }
}