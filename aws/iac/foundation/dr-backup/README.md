<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| s3\_backup\_historico | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git | main |
| s3\_netbackup | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git | main |
| this\_sae1 | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | 1.0.0 |
| this\_use1 | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | 1.0.0 |
| vpc\_sae1 | terraform-aws-modules/vpc/aws | 5.0.0 |
| vpc\_use1 | terraform-aws-modules/vpc/aws | 5.0.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudformation_stack.instance_scheduler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudformation_stack) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.dr_backup_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.dr_backup_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_flow_log.flow_log_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_flow_log.flow_log_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_instance_profile.sae1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.use1_session_manager_profile](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_policy.grafana_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.policy_s3_netbackup](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.grafana_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.sae1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.use1_session_manager_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.grafana_role_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_route.dr_backup_sae1_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route.dr_backup_use1_internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_cloud_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_cloud_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_sae1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_route53_resolver_rule_association.outbound_rule_association_use1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_resolver_rule_association) | resource |
| [aws_s3_bucket.flow_log_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_vpc_endpoint.s3_sae1_gateway_interno](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.s3_use1_gateway_interno](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_iam_policy_document.netbackup_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |
| [terraform_remote_state.shared](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| private\_subnets\_sae1\_tags | Tags para todas as subnets privadas de SAE1 | `map(string)` | `{}` | no |
| private\_subnets\_use1\_tags | Tags para todas as subnets privadas de USE1 | `map(string)` | `{}` | no |
| public\_subnets\_sae1\_tags | Tags para todas as subnets públicas de SAE1 | `map(string)` | `{}` | no |
| public\_subnets\_use1\_tags | Tags para todas as subnets públicas de USE1 | `map(string)` | `{}` | no |
| tags | Tags obrigatórias para todos os recursos. | `map(string)` | <pre>{<br>  "Environment": "backup",<br>  "IAC": true,<br>  "map-migrated": "d-server-01oiau1h5afqhv"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc\_sae1\_id | ID da VPC de SAE1 |
| vpc\_sae1\_private\_subnets\_ids | IDs da subnets privadas da VPC de SAE1 |
| vpc\_sae1\_public\_subnets\_ids | IDs da subnets públicas da VPC de SAE1 |
| vpc\_use1\_id | ID da VPC de USE1 |
| vpc\_use1\_private\_subnets\_ids | IDs da subnets privadas da VPC de USE1 |
| vpc\_use1\_public\_subnets\_ids | IDs da subnets públicas da VPC de USE1 |
<!-- END_TF_DOCS -->