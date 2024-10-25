<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| r53\_edu | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| r53\_sbx | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| r53\_workload\_cer | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| r53\_workload\_dev | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| r53\_workload\_hml | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
| r53\_workload\_prd | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/route-53-zone.git | main |
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
| [aws_db_subnet_group.db_subnet_group_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_db_subnet_group.db_subnet_group_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_ebs_volume.dns_sysvol_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ebs_volume) | resource |
| [aws_ec2_tag.r53_resolver_endpoints_map_migrated_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_tag.r53_resolver_endpoints_map_migrated_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.shared_services_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.shared_services_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_flow_log.flow_log_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.flow_log_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_instance_profile.dns_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.sae1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.use1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.grafana_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.dns_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.grafana_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sae1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.use1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.grafana_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.dns_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_ram_principal_association.ram_outbound_resolver_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.ram_outbound_resolver_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.ram_outbound_resolver_galgo_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.ram_outbound_resolver_galgo_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.ram_outbound_resolver_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_principal_association.ram_outbound_resolver_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_principal_association) | resource |
| [aws_ram_resource_association.ram_outbound_resolver_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.ram_outbound_resolver_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.ram_outbound_resolver_galgo_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.ram_outbound_resolver_galgo_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.ram_outbound_resolver_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_association.ram_outbound_resolver_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_association) | resource |
| [aws_ram_resource_share.ram_outbound_resolver_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.ram_outbound_resolver_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.ram_outbound_resolver_galgo_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.ram_outbound_resolver_galgo_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.ram_outbound_resolver_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_ram_resource_share.ram_outbound_resolver_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ram_resource_share) | resource |
| [aws_redshift_subnet_group.redshift_subnet_group_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |
| [aws_redshift_subnet_group.redshift_subnet_group_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/redshift_subnet_group) | resource |
| [aws_route.shared_services_sae1_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.shared_services_use1_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_resolver_endpoint.inbound_endpoint_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_endpoint.inbound_endpoint_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_endpoint.outbound_endpoint_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_endpoint.outbound_endpoint_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_endpoint) | resource |
| [aws_route53_resolver_rule.outbound_rule_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.outbound_rule_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.outbound_rule_galgo_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.outbound_rule_galgo_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.outbound_rule_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule.outbound_rule_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_galgo_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_galgo_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_zone.r53_anbima_cloud](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone) | resource |
| [aws_route_table_association.databricks_subnet_to_private_rtb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_s3_bucket.flow_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_security_group.ec2_dns_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.outbound_endpoint_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.outbound_endpoint_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_ses_domain_dkim.anbima_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_dkim.sistema_convenio_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_dkim) | resource |
| [aws_ses_domain_identity.anbima_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_ses_domain_identity.sistema_convenio_com_br](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ses_domain_identity) | resource |
| [aws_subnet.databricks_network](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_volume_attachment.dns_sysvol_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/volume_attachment) | resource |
| [aws_network_interfaces.r53_resolver_enis_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_interfaces) | data source |
| [aws_network_interfaces.r53_resolver_enis_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/network_interfaces) | data source |
| [aws_organizations_organization.this_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organization.this_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organization.this_galgo_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organization.this_galgo_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organization.this_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_organizations_organization.this_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/organizations_organization) | data source |
| [aws_route53_resolver_endpoint.indound_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.indound_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.outbound_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [aws_route53_resolver_endpoint.outbound_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_resolver_endpoint) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aws\_ad\_ip | IP do AD na shared-services | `string` | `"10.92.22.187"` | no |
| on\_premisses\_ad\_ip | IP do AD on-premisses | `string` | `"10.150.200.20"` | no |
| private\_certificate\_domains | Lista de domínios para certificado privado ACM. | `list(any)` | <pre>[<br/>  "*.anbima.cloud",<br/>  "dev.anbima.cloud",<br/>  "*.dev.anbima.cloud",<br/>  "hml.anbima.cloud",<br/>  "*.hml.anbima.cloud",<br/>  "cer.anbima.cloud",<br/>  "*.cer.anbima.cloud",<br/>  "prd.anbima.cloud",<br/>  "*.prd.anbima.cloud"<br/>]</pre> | no |
| private\_subnets\_sae1\_tags | Tags para todas as subnets privadas de SAE1 | `map(string)` | `{}` | no |
| private\_subnets\_use1\_tags | Tags para todas as subnets privadas de USE1 | `map(string)` | `{}` | no |
| public\_certificate\_domains | Lista de domínios para certificado público ACM. | `list(any)` | <pre>[<br/>  "*.anbima.com.br",<br/>  "dev.anbima.com.br",<br/>  "*.dev.anbima.com.br",<br/>  "hml.anbima.com.br",<br/>  "*.hml.anbima.com.br",<br/>  "cer.anbima.com.br",<br/>  "*.cer.anbima.com.br",<br/>  "prd.anbima.com.br",<br/>  "*.prd.anbima.com.br"<br/>]</pre> | no |
| public\_subnets\_sae1\_tags | Tags para todas as subnets públicas de SAE1 | `map(string)` | `{}` | no |
| public\_subnets\_use1\_tags | Tags para todas as subnets públicas de USE1 | `map(string)` | `{}` | no |
| rtm\_dns1\_ip | IP do DNS1 | `string` | `"10.0.33.2"` | no |
| rtm\_dns2\_ip | IP do DNS2 | `string` | `"10.0.17.2"` | no |
| tags | Tags obrigatórias para todos os recursos. | `map(string)` | <pre>{<br/>  "Environment": "shared",<br/>  "IAC": true,<br/>  "map-migrated": "d-server-01oiau1h5afqhv"<br/>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| acm\_sae1\_certificate\_private | Certificado privado de sa-east-1. |
| acm\_sae1\_certificate\_public | Certificado público de sa-east-1. |
| acm\_use1\_certificate\_private | Certificado privado de us-east-1. |
| acm\_use1\_certificate\_public | Certificado público de us-east-1. |
| resolver\_rule\_cloud\_sae1 | Rule 2 do Outbound Endpoint do Route 53 Resolver |
| resolver\_rule\_cloud\_use1 | Rule 2 do Outbound Endpoint do Route 53 Resolver |
| resolver\_rule\_galgo\_sae1 | Rule do Outbound Endpoint do Route 53 Resolver |
| resolver\_rule\_galgo\_use1 | Rule do Outbound Endpoint do Route 53 Resolver |
| resolver\_rule\_sae1 | Rule do Outbound Endpoint do Route 53 Resolver |
| resolver\_rule\_use1 | Rule do Outbound Endpoint do Route 53 Resolver |
| vpc\_sae1\_database\_subnet\_group\_name | Nome do database subnet group para RDS de SAE1. |
| vpc\_sae1\_id | ID da VPC de SAE1 |
| vpc\_sae1\_private\_subnets\_cidr\_blocks | CIDR blocks das subnets privadas da VPC de SAE1 |
| vpc\_sae1\_private\_subnets\_ids | IDs da subnets privadas da VPC de SAE1 |
| vpc\_sae1\_public\_subnets\_cidr\_blocks | CIDR blocks das subnets publicas da VPC de SAE1 |
| vpc\_sae1\_public\_subnets\_ids | IDs da subnets públicas da VPC de SAE1 |
| vpc\_sae1\_redshift\_subnet\_group\_name | Nome do redshift subnet group para Redshifts de SAE1. |
| vpc\_use1\_database\_subnet\_group\_name | Nome do database subnet group para RDS de USE1. |
| vpc\_use1\_databricks\_subnets\_cidr\_blocks | CIDR blocks das subnets do Databricks de USE1 |
| vpc\_use1\_databricks\_subnets\_ids | IDs da subnets privadas do Databricks de USE1 |
| vpc\_use1\_id | ID da VPC de USE1 |
| vpc\_use1\_private\_subnets\_cidr\_blocks | CIDR blocks das subnets privadas da VPC de USE1 |
| vpc\_use1\_private\_subnets\_ids | IDs da subnets privadas da VPC de USE1 |
| vpc\_use1\_public\_subnets\_cidr\_blocks | CIDR blocks das subnets publicas da VPC de USE1 |
| vpc\_use1\_public\_subnets\_ids | IDs da subnets públicas da VPC de USE1 |
| vpc\_use1\_redshift\_subnet\_group\_name | Nome do redshift subnet group para Redshifts de USE1. |
<!-- END_TF_DOCS -->