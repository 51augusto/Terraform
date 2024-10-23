module "se_liga_na_fraude" {
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
  site_name        = "se-liga"
  tg_name          = "se-liga"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.1"
  domain_names     = ["seliganafraude.anbima.com.br", "seliganafraude.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-se-liga-na-fraude-9fcf0h"
  min_capacity     = 2
  max_capacity     = 4
  resources = {
    cpu    = 1024,
    memory = 2048
  }
}

module "selic_aniversario" {
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
  site_name        = "selic-aniversario"
  tg_name          = "selic-aniversario"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php7.4"
  domain_names     = ["selic40.anbima.com.br", "selic40.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-selic-aniversario-9hYwyo"
  min_capacity     = 1
  max_capacity     = 2
}

module "hotsite_feed" {
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
  site_name        = "feed"
  tg_name          = "feed"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php7.4"
  domain_names     = ["feed.anbima.com.br", "feed.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-hotsite-feed-cvzsFS"
  min_capacity     = 2
  max_capacity     = 4
}

module "hotsite_associados" {
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
  site_name        = "associados"
  tg_name          = "associados"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.1"
  domain_names     = ["associados.anbima.com.br", "associados.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-hotsite-associados-Ttg2xR"
  min_capacity     = 1
  max_capacity     = 2
}

module "rededei" {
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
  site_name        = "rededei"
  tg_name          = "rededei"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.1"
  domain_names     = ["rededei.anbima.com.br", "rededei.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-rededei-bYZysZ"
  min_capacity     = 1
  max_capacity     = 2
}

module "data_cms" {
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
  site_name        = "data-cms"
  tg_name          = "data-cms"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.1"
  domain_names     = ["data-cms.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-data-cms-XAgs4r"
  min_capacity     = 1
  max_capacity     = 2
  env_vars = [
    {
      name  = "WORDPRESS_CONFIG_EXTRA"
      value = "define('HEADLESS_MODE_CLIENT_URL', 'https://data.anbima.com.br');"
    }
  ]
}

module "plano_de_acao_2023" {
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
  site_name        = "plano-de-acao-2023"
  tg_name          = "plano-acao-2023"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.2"
  domain_names     = ["prioridades.anbima.com.br", "plano-de-acao-2023.prd.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-plano-de-acao-2023-xFPhAw"
  min_capacity     = 1
  max_capacity     = 2
}

module "anbimaedu" {
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
  site_name        = "anbimaedu"
  tg_name          = "anbimaedu"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.2"
  domain_names     = ["anbimaedu.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-anbima-edu-V0wKkJ"
  min_capacity     = 2
  max_capacity     = 10
}

module "onboarding_aderentes" {
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
  site_name        = "onboarding-aderentes"
  tg_name          = "onb-aderentes"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.2"
  domain_names     = ["onboarding-aderentes.prd.anbima.com.br", "pass.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-onboarding-aderentes-SC1EPn"
  min_capacity     = 1
  max_capacity     = 2
}

module "autorregulacao25" {
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
  site_name        = "autorregulacao25"
  tg_name          = "autorregulacao25"
  image            = "788006387775.dkr.ecr.us-east-1.amazonaws.com/ecr-cicd-shared-use1/wordpress:php8.2"
  domain_names     = ["autorregulacao25.prd.anbima.com.br", "autorregulacao25.anbima.com.br"]
  env_secret_arn   = "arn:aws:secretsmanager:us-east-1:899836677866:secret:secret-wordpress-prd-use1-autorregulacao25-e2UOCv"
  min_capacity     = 2
  max_capacity     = 5
}