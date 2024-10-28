resource "aws_acm_certificate" "feed" {
  domain_name               = "feed.anbima.com.br"
  subject_alternative_names = ["*.feed.anbima.com.br"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "anbimaedu" {
  domain_name               = "anbimaedu.com.br"
  subject_alternative_names = ["*.anbimaedu.com.br"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}