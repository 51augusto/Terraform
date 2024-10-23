module "phpmyadmin" {
  source           = "./service"
  ecs_cluster_arn  = module.ecs.cluster_arn
  vpc_id           = data.terraform_remote_state.wordpress.outputs.vpc_id
  subnet_ids       = data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids
  alb_listener_arn = module.alb.https_listener_arns[0]
  alb_sg_id        = aws_security_group.alb_security_group.id
  log_group        = aws_cloudwatch_log_group.log_group.name
  image            = "public.ecr.aws/docker/library/phpmyadmin:5.2.0-apache"
  site_name        = "phpmyadmin"
  domain_names     = ["wordpress-phpmyadmin.anbima.cloud"]
  port             = 80
  desired_count    = 1
  env_vars = [
    {
      name  = "PMA_ARBITRARY"
      value = "1"
    },
    {
      name  = "UPLOAD_LIMIT"
      value = "209715200" # 1024 * 1024 * 200 = 200 MB
    }
  ]
}

module "bastion" {
  source                 = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/ec2.git?ref=main"
  component_name         = "wordpress"
  environment            = "prd"
  region                 = "us-east-1"
  name                   = "bastion"
  ami                    = "ami-0f9fc25dd2506cf6d"
  instance_type          = "t3a.small"
  termination_protection = true
  prometheus_exporter    = false
  subnet                 = data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids[0]
  tags = {
    Role               = "Wordpress Bastion"
    Version            = "Amazon Linux 2"
    StartStopScheduled = "poweroff"
    Backup             = "false"
  }
}
