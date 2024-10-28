<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | git::ssh://git@github.com/51augusto/Terraform.git//aws/iac/modules/naming-convention | master |
| vpc | terraform-aws-modules/vpc/aws | 5.14.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_ec2_transit_gateway_vpc_attachment.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_transit_gateway_vpc_attachment) | resource |
| [aws_route.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route) | resource |
| [terraform_remote_state.network](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| vpc\_database\_subnet\_group\_name | Nome do database subnet group para RDS de USE1. |
| vpc\_id | ID da VPC |
| vpc\_private\_subnets\_ids | IDs da subnets privadas da VPC |
| vpc\_public\_subnets\_ids | IDs da subnets públicas da VPC |
<!-- END_TF_DOCS -->