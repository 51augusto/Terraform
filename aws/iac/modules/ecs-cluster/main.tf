module "ecs" {
  source                      = "terraform-aws-modules/ecs/aws"
  version                     = "5.2.0"
  cluster_name                = local.cluster_name
  create_cloudwatch_log_group = false
  cluster_settings = {
    name  = "containerInsights"
    value = "disabled"
  }
  tags = {
    Name = local.cluster_name
  }
}

module "service" {
  source            = "./fargate-service"
  for_each          = var.services
  component_name    = var.component_name
  environment       = var.environment
  region            = var.region
  ecs_cluster_arn   = module.ecs.cluster_arn
  ecs_cluster_name  = local.cluster_name
  name              = each.key
  task_role_arn     = each.value.role_arn
  cpu               = try(each.value.cpu, 256)
  memory            = try(each.value.memory, 512)
  min_capacity      = try(each.value.min_capacity, 0)
  max_capacity      = try(each.value.max_capacity, 0)
  startup_schedule  = try(each.value.startup_schedule, null)
  shutdown_schedule = try(each.value.shutdown_schedule, null)
  vpc_id            = try(each.value.vpc_id, var.vpc_id)
  subnet_ids        = try(each.value.subnet_ids, var.subnet_ids)
  secret_arns       = try(each.value.secret_arns, var.secret_arns)
  endpoint          = try(each.value.endpoint, null)
  spot              = try(each.value.spot, var.spot)
}