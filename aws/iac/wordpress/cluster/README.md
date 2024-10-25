<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| alb | terraform-aws-modules/alb/aws | 9.12.0 |
| anbimaedu | ./wp-service | n/a |
| anbimaedu\_zone | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| autorregulacao25 | ./wp-service | n/a |
| bastion | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/ec2.git | main |
| corretorainvesteja | ./wp-service | n/a |
| corretorainvesteja\_zone | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| data\_cms | ./wp-service | n/a |
| ecs | terraform-aws-modules/ecs/aws | 5.11.4 |
| edufinanceira\_zone | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| hotsite\_associados | ./wp-service | n/a |
| hotsite\_feed | ./wp-service | n/a |
| metacrypto | ./wp-service | n/a |
| metacrypto\_zone | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| onboarding\_aderentes | ./wp-service | n/a |
| phpmyadmin | ./service | n/a |
| plano\_de\_acao\_2023 | ./wp-service | n/a |
| rds\_aurora\_mysql | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/rds-aurora.git | main |
| rds\_aurora\_mysql\_external | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/rds-aurora.git | main |
| rededei | ./wp-service | n/a |
| se\_liga\_na\_fraude | ./wp-service | n/a |
| selic\_aniversario | ./wp-service | n/a |
| this | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| virtualfinance | ./wp-service | n/a |
| yellowinvest | ./wp-service | n/a |
| yellowinvest\_zone | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.anbimaedu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.corretorainvesteja](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.edufinanceira](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.feed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.metacrypto](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.yellowinvest](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lb_listener_rule.corretorainvesteja_www_redirect_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.edufinanceira_www_redirect_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.feed_www_redirect_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.metacrypto_www_redirect_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_lb_listener_rule.yellowinvest_www_redirect_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener_rule) | resource |
| [aws_security_group.alb_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_wafv2_web_acl_association.alb_web_acl_association](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/wafv2_web_acl_association) | resource |
| [aws_secretsmanager_secret_version.db_root_credentials](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/secretsmanager_secret_version) | data source |
| [aws_subnet.private_subnets](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [terraform_remote_state.main](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.monitoring](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.waf](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.wordpress](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->