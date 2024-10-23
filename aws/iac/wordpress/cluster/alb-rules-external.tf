resource "aws_lb_listener_rule" "edufinanceira_www_redirect_rule" {
  listener_arn = module.alb.https_listener_arns[0]

  action {
    type = "redirect"
    redirect {
      host        = "edufinanceira-lac.org.br"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["www.edufinanceira-lac.org.br"]
    }
  }
}

resource "aws_lb_listener_rule" "metacrypto_www_redirect_rule" {
  listener_arn = module.alb.https_listener_arns[0]

  action {
    type = "redirect"
    redirect {
      host        = "metacryptoinvest.com.br"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["www.metacryptoinvest.com.br"]
    }
  }
}

resource "aws_lb_listener_rule" "corretorainvesteja_www_redirect_rule" {
  listener_arn = module.alb.https_listener_arns[0]

  action {
    type = "redirect"
    redirect {
      host        = "corretorainvesteja.com.br"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["www.corretorainvesteja.com.br"]
    }
  }
}

resource "aws_lb_listener_rule" "yellowinvest_www_redirect_rule" {
  listener_arn = module.alb.https_listener_arns[0]

  action {
    type = "redirect"
    redirect {
      host        = "yellowinvest.com.br"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["www.yellowinvest.com.br"]
    }
  }
}