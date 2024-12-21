module "alb" {
  source                      = "terraform-aws-modules/alb/aws"
  version                     = "9.13.0"
  name                        = local.alb_name
  load_balancer_type          = "application"
  vpc_id                      = data.terraform_remote_state.wordpress.outputs.vpc_id
  subnets                     = data.terraform_remote_state.wordpress.outputs.vpc_public_subnets_ids
  security_groups             = [aws_security_group.alb_security_group.id]
  enable_deletion_protection  = true
  idle_timeout                = 4000
  enable_xff_client_port      = false
  create_security_group       = false
  listener_ssl_policy_default = "ELBSecurityPolicy-FS-1-2-Res-2020-10"

  access_logs = {
    enabled = true
    bucket  = data.terraform_remote_state.monitoring.outputs.lb_access_logs_bucket_use1.bucket
    prefix  = local.alb_name
  }

  http_tcp_listeners = [
    {
      port        = 80
      protocol    = "HTTP"
      action_type = "redirect"
      redirect = {
        port        = "443"
        protocol    = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  https_listeners = [{
    port            = 443
    protocol        = "HTTPS"
    certificate_arn = data.terraform_remote_state.main.outputs.acm_use1_certificate_public.arn
    action_type     = "fixed-response"
    fixed_response = {
      content_type = "text/plain"
      message_body = "Not found"
      status_code  = "404"
    }
  }]

  extra_ssl_certs = [
    {
      https_listener_index = 0
      certificate_arn      = data.terraform_remote_state.main.outputs.acm_use1_certificate_private.arn
    },
    {
      https_listener_index = 0
      certificate_arn      = aws_acm_certificate.feed.arn
    },
    {
      https_listener_index = 0
      certificate_arn      = aws_acm_certificate.edufinanceira.arn
    },
    {
      https_listener_index = 0
      certificate_arn      = aws_acm_certificate.metacrypto.arn
    },
    {
      https_listener_index = 0
      certificate_arn      = aws_acm_certificate.corretorainvesteja.arn
    },
    {
      https_listener_index = 0
      certificate_arn      = aws_acm_certificate.yellowinvest.arn
    },
    {
      https_listener_index = 0
      certificate_arn      = aws_acm_certificate.anbimaedu.arn
    }
  ]
}

resource "aws_wafv2_web_acl_association" "alb_web_acl_association" {
  resource_arn = module.alb.lb_arn
  web_acl_arn  = data.terraform_remote_state.waf.outputs.regional_web_acl_use1.arn
}

resource "aws_security_group" "alb_security_group" {
  vpc_id = data.terraform_remote_state.wordpress.outputs.vpc_id
  name   = local.alb_sg_name

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = local.alb_sg_name
  }
}