resource "aws_ses_domain_identity" "anbima_com_br" {
  provider = aws.use1
  domain   = "anbima.com.br"
}

resource "aws_ses_domain_dkim" "anbima_com_br" {
  provider = aws.use1
  domain   = aws_ses_domain_identity.anbima_com_br.domain
}

resource "aws_ses_domain_identity" "sistema_convenio_com_br" {
  provider = aws.use1
  domain   = "sistema-convenio.com.br"
}

resource "aws_ses_domain_dkim" "sistema_convenio_com_br" {
  provider = aws.use1
  domain   = aws_ses_domain_identity.sistema_convenio_com_br.domain
}