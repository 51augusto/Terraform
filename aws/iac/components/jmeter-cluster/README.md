<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| asg\_sae1 | ./auto-scaling-group/ | n/a |
| asg\_use1 | ./auto-scaling-group/ | n/a |
| jmeter\_server\_sae1 | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/ec2.git | main |
| jmeter\_server\_use1 | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/ec2.git | main |
| this\_sae1 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |
| this\_use1 | git@github.com:51augusto/Terraform/aws/iac/modules/naming-convention.git | master |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.jmeter_describe_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_policy.jmeter_get_pkg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [terraform_remote_state.remote](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_name | Nome da conta AWS | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `sandbox` | `string` | n/a | yes |
| mandatory\_tags | Tags obrigatórias para todos os recursos. | `object({ Environment = string, IAC = bool })` | <pre>{<br/>  "Environment": "shared",<br/>  "IAC": true<br/>}</pre> | no |
| map\_migration\_tags | Tags para serem aplicadas em todos os recursos (programa de incentivo de migração MAP). | `map(string)` | <pre>{<br/>  "map-migrated": "d-server-01oiau1h5afqhv"<br/>}</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->