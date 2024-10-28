module "metacrypto" {
  source           = "./wp-service"
  ecs_cluster_arn  = module.ecs.cluster_arn
  ecs_cluster_name = local.cluster_name
  vpc_id           = data.terraform_remote_state.wordpress.outputs.vpc_id
  subnet_ids       = data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids
  alb_arn          = module.alb.lb_arn
  alb_listener_arn = module.alb.https_listener_arns[0]
  alb_sg_id        = aws_security_group.alb_security_group.id
  bastion_sg_id    = module.bastion.security_group.id
  log_group        = aws_cloudwatch_log_group.log_group.name
  site_name        = "metacrypto"
  tg_name          = "metacrypto"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.1"
  domain_names     = ["metacryptoinvest.com.br", "metacryptoinvest.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-metacrypto-kA519u"
  min_capacity     = 1
  max_capacity     = 2
}

module "corretorainvesteja" {
  source           = "./wp-service"
  ecs_cluster_arn  = module.ecs.cluster_arn
  ecs_cluster_name = local.cluster_name
  vpc_id           = data.terraform_remote_state.wordpress.outputs.vpc_id
  subnet_ids       = data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids
  alb_arn          = module.alb.lb_arn
  alb_listener_arn = module.alb.https_listener_arns[0]
  alb_sg_id        = aws_security_group.alb_security_group.id
  bastion_sg_id    = module.bastion.security_group.id
  log_group        = aws_cloudwatch_log_group.log_group.name
  site_name        = "investeja"
  tg_name          = "investeja"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php7.4"
  domain_names     = ["corretorainvesteja.com.br", "corretorainvesteja.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-corretorainvesteja-K9cv6A"
  min_capacity     = 1
  max_capacity     = 2
  env_vars = [
    {
      name  = "WORDPRESS_TABLE_PREFIX"
      value = "mc_"
    }
  ]
}

module "virtualfinance" {
  source           = "./wp-service"
  ecs_cluster_arn  = module.ecs.cluster_arn
  ecs_cluster_name = local.cluster_name
  vpc_id           = data.terraform_remote_state.wordpress.outputs.vpc_id
  subnet_ids       = data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids
  alb_arn          = module.alb.lb_arn
  alb_listener_arn = module.alb.https_listener_arns[0]
  alb_sg_id        = aws_security_group.alb_security_group.id
  bastion_sg_id    = module.bastion.security_group.id
  log_group        = aws_cloudwatch_log_group.log_group.name
  site_name        = "virtualfinance"
  tg_name          = "virtualfinance"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.1"
  domain_names     = ["virtualfinance.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-virtualfinance-hzSbRn"
  min_capacity     = 1
  max_capacity     = 2
}

module "yellowinvest" {
  source           = "./wp-service"
  ecs_cluster_arn  = module.ecs.cluster_arn
  ecs_cluster_name = local.cluster_name
  vpc_id           = data.terraform_remote_state.wordpress.outputs.vpc_id
  subnet_ids       = data.terraform_remote_state.wordpress.outputs.vpc_private_subnets_ids
  alb_arn          = module.alb.lb_arn
  alb_listener_arn = module.alb.https_listener_arns[0]
  alb_sg_id        = aws_security_group.alb_security_group.id
  bastion_sg_id    = module.bastion.security_group.id
  log_group        = aws_cloudwatch_log_group.log_group.name
  site_name        = "yellowinvest"
  tg_name          = "yellowinvest"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.1"
  domain_names     = ["yellowinvest.prd.anbima.com.br", "yellowinvest.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-yellowinvest-BVc3k1"
  min_capacity     = 1
  max_capacity     = 2
}