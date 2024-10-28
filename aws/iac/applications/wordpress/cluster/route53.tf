module "edufinanceira_zone" {
  source             = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  public_zone        = true
  public_domain_name = "edufinanceira-lac.org.br"
}

module "metacrypto_zone" {
  source             = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  public_zone        = true
  public_domain_name = "metacryptoinvest.com.br"
}

module "corretorainvesteja_zone" {
  source             = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  public_zone        = true
  public_domain_name = "corretorainvesteja.com.br"
}

module "yellowinvest_zone" {
  source             = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  public_zone        = true
  public_domain_name = "yellowinvest.com.br"
}

module "anbimaedu_zone" {
  source             = "git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git?ref=main"
  public_zone        = true
  public_domain_name = "anbimaedu.com.br"
}