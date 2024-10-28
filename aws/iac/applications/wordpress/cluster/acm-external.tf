resource "aws_acm_certificate" "edufinanceira" {
  domain_name               = "edufinanceira-lac.org.br"
  subject_alternative_names = ["*.edufinanceira-lac.org.br"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "metacrypto" {
  domain_name               = "metacryptoinvest.com.br"
  subject_alternative_names = ["*.metacryptoinvest.com.br"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "corretorainvesteja" {
  domain_name               = "corretorainvesteja.com.br"
  subject_alternative_names = ["*.corretorainvesteja.com.br"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "yellowinvest" {
  domain_name               = "yellowinvest.com.br"
  subject_alternative_names = ["*.yellowinvest.com.br"]
  validation_method         = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}