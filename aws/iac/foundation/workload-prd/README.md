<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this\_sae1 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| this\_use1 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| vpc\_sae1 | terraform-aws-modules/vpc/aws | 5.14.0 |
| vpc\_use1 | terraform-aws-modules/vpc/aws | 5.14.0 |

## Resources

| Name | Type |
|------|------|
| [aws_acm_certificate.certificate_private_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.certificate_private_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.certificate_public_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_acm_certificate.certificate_public_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/acm_certificate) | resource |
| [aws_cloudformation_stack.instance_scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.workload_prd_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.workload_prd_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_elasticache_subnet_group.elasticache_subnet_group_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_elasticache_subnet_group.elasticache_subnet_group_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) | resource |
| [aws_flow_log.flow_log_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.flow_log_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_instance_profile.sae1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.use1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.grafana_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.grafana_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sae1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.use1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.grafana_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route.workload_prd_sae1_route_db2internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.workload_prd_sae1_route_intra2internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.workload_prd_use1_route_db2internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.workload_prd_use1_route_intra2internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_galgo_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_galgo_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_s3_bucket.flow_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_ses_domain_dkim.anbima_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_dkim.sistema_convenio_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.anbima_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_identity.sistema_convenio_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_vpc_endpoint.s3_gateway_interno](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| private\_subnets\_sae1\_tags | Tags para todas as subnets privadas de SAE1 | `map(string)` | n/a | yes |
| private\_subnets\_use1\_tags | Tags para todas as subnets privadas de USE1 | `map(string)` | n/a | yes |
| public\_subnets\_sae1\_tags | Tags para todas as subnets públicas de SAE1 | `map(string)` | n/a | yes |
| public\_subnets\_use1\_tags | Tags para todas as subnets públicas de USE1 | `map(string)` | n/a | yes |
| private\_certificate\_domains | Lista de domínios para certificado privado ACM. | `list(any)` | <pre>[<br/>  "*.anbima.cloud",<br/>  "dev.anbima.cloud",<br/>  "*.dev.anbima.cloud",<br/>  "hml.anbima.cloud",<br/>  "*.hml.anbima.cloud",<br/>  "cer.anbima.cloud",<br/>  "*.cer.anbima.cloud",<br/>  "prd.anbima.cloud",<br/>  "*.prd.anbima.cloud"<br/>]</pre> | no |
| public\_certificate\_domains | Lista de domínios para certificado público ACM. | `list(any)` | <pre>[<br/>  "*.anbima.com.br",<br/>  "dev.anbima.com.br",<br/>  "*.dev.anbima.com.br",<br/>  "hml.anbima.com.br",<br/>  "*.hml.anbima.com.br",<br/>  "cer.anbima.com.br",<br/>  "*.cer.anbima.com.br",<br/>  "prd.anbima.com.br",<br/>  "*.prd.anbima.com.br"<br/>]</pre> | no |
| tags | Tags obrigatórias para todos os recursos. | `map(string)` | <pre>{<br/>  "Environment": "prd",<br/>  "IAC": true,<br/>  "map-migrated": "d-server-01oiau1h5afqhv"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| acm\_sae1\_certificate\_private | Certificado privado de sa-east-1. |
| acm\_sae1\_certificate\_public | Certificado público de sa-east-1. |
| acm\_use1\_certificate\_private | Certificado privado de us-east-1. |
| acm\_use1\_certificate\_public | Certificado público de us-east-1. |
| vpc\_sae1\_database\_subnet\_group\_name | Nome do database subnet group para RDS de SAE1. |
| vpc\_sae1\_database\_subnets\_cidr\_blocks | CIDR blocks das subnets de database da VPC de SAE1 |
| vpc\_sae1\_database\_subnets\_ids | IDs das subnets de database da VPC de SAE1 |
| vpc\_sae1\_elasticache\_subnet\_group\_name | Nome do elasticache subnet group para Elasticaches de SAE1. |
| vpc\_sae1\_id | ID da VPC de SAE1 |
| vpc\_sae1\_private\_subnets\_cidr\_blocks | CIDR blocks das subnets privadas da VPC de SAE1 |
| vpc\_sae1\_private\_subnets\_ids | IDs das subnets privadas da VPC de SAE1 |
| vpc\_sae1\_public\_subnets\_cidr\_blocks | CIDR blocks das subnets publicas da VPC de SAE1 |
| vpc\_sae1\_public\_subnets\_ids | IDs das subnets públicas da VPC de SAE1 |
| vpc\_use1\_database\_subnet\_group\_name | Nome do database subnet group para RDS de USE1. |
| vpc\_use1\_database\_subnets\_cidr\_blocks | CIDR blocks das subnets de database da VPC de USE1 |
| vpc\_use1\_database\_subnets\_ids | IDs das subnets de database da VPC de USE1 |
| vpc\_use1\_elasticache\_subnet\_group\_name | Nome do elasticache subnet group para Elasticaches de USE1. |
| vpc\_use1\_id | ID da VPC de USE1 |
| vpc\_use1\_private\_subnets\_cidr\_blocks | CIDR blocks das subnets privadas da VPC de USE1 |
| vpc\_use1\_private\_subnets\_ids | IDs das subnets privadas da VPC de USE1 |
| vpc\_use1\_public\_subnets\_cidr\_blocks | CIDR blocks das subnets publicas da VPC de USE1 |
| vpc\_use1\_public\_subnets\_ids | IDs das subnets públicas da VPC de USE1 |
<!-- END_TF_DOCS -->