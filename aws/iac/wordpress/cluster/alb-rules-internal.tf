resource "aws_lb_listener_rule" "feed_www_redirect_rule" {
  listener_arn = module.alb.https_listener_arns[0]

  action {
    type = "redirect"
    redirect {
      host        = "feed.anbima.com.br"
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    host_header {
      values = ["www.feed.anbima.com.br"]
    }
  }
}