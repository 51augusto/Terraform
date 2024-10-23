resource "aws_acm_certificate" "certificate_private_use1" {
  provider                  = aws.use1
  domain_name               = "anbima.cloud"
  subject_alternative_names = var.private_certificate_domains
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "certificate_private_sae1" {
  provider                  = aws.sae1
  domain_name               = "anbima.cloud"
  subject_alternative_names = var.private_certificate_domains
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "certificate_public_use1" {
  provider                  = aws.use1
  domain_name               = "anbima.com.br"
  subject_alternative_names = var.public_certificate_domains
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "certificate_public_sae1" {
  provider                  = aws.sae1
  domain_name               = "anbima.com.br"
  subject_alternative_names = var.public_certificate_domains
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}