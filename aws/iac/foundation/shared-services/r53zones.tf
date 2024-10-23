resource "aws_route53_zone" "r53_anbima_cloud" {
  provider = aws.use1
  name     = "anbima.cloud"
  vpc {
    vpc_id     = module.vpc_use1.vpc_id
    vpc_region = "us-east-1"
  }
  vpc {
    vpc_id     = module.vpc_sae1.vpc_id
    vpc_region = "sa-east-1"
  }
}

module "r53_workload_dev" {
  source                  = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  providers               = { aws = aws.use1 }
  private_zone            = true
  public_zone             = true
  public_sub_domain_name  = "dev"
  private_sub_domain_name = "dev"
  private_zone_vpc_ids = {
    "use1" : {
      vpc_id = module.vpc_use1.vpc_id
      region = "us-east-1"
    },
    "sae1" : {
      vpc_id = module.vpc_sae1.vpc_id
      region = "sa-east-1"
    }
  }
}

module "r53_workload_cer" {
  source                  = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  providers               = { aws = aws.use1 }
  private_zone            = true
  public_zone             = true
  public_sub_domain_name  = "cer"
  private_sub_domain_name = "cer"
  private_zone_vpc_ids = {
    "use1" : {
      vpc_id = module.vpc_use1.vpc_id
      region = "us-east-1"
    },
    "sae1" : {
      vpc_id = module.vpc_sae1.vpc_id
      region = "sa-east-1"
    }
  }
}

module "r53_workload_hml" {
  source                  = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  providers               = { aws = aws.use1 }
  private_zone            = true
  public_zone             = true
  public_sub_domain_name  = "hml"
  private_sub_domain_name = "hml"
  private_zone_vpc_ids = {
    "use1" : {
      vpc_id = module.vpc_use1.vpc_id
      region = "us-east-1"
    },
    "sae1" : {
      vpc_id = module.vpc_sae1.vpc_id
      region = "sa-east-1"
    }
  }
}

module "r53_workload_prd" {
  source                  = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  providers               = { aws = aws.use1 }
  private_zone            = true
  public_zone             = true
  public_sub_domain_name  = "prd"
  private_sub_domain_name = "prd"
  private_zone_vpc_ids = {
    "use1" : {
      vpc_id = module.vpc_use1.vpc_id
      region = "us-east-1"
    },
    "sae1" : {
      vpc_id = module.vpc_sae1.vpc_id
      region = "sa-east-1"
    }
  }
}

module "r53_sbx" {
  source                  = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  providers               = { aws = aws.use1 }
  private_zone            = true
  public_zone             = true
  public_sub_domain_name  = "sbx"
  private_sub_domain_name = "sbx"
  private_zone_vpc_ids = {
    "use1" : {
      vpc_id = module.vpc_use1.vpc_id
      region = "us-east-1"
    },
    "sae1" : {
      vpc_id = module.vpc_sae1.vpc_id
      region = "sa-east-1"
    }
  }
}

module "r53_edu" {
  source                  = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  providers               = { aws = aws.use1 }
  private_zone            = true
  public_zone             = true
  public_sub_domain_name  = "edu"
  private_sub_domain_name = "edu"
  private_zone_vpc_ids = {
    "use1" : {
      vpc_id = module.vpc_use1.vpc_id
      region = "us-east-1"
    },
    "sae1" : {
      vpc_id = module.vpc_sae1.vpc_id
      region = "sa-east-1"
    }
  }
}