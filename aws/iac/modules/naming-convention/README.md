<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| custom | cloudposse/label/null | 0.25.0 |
| root | cloudposse/label/null | 0.25.0 |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| region | AWS Region | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| aldo\_context | Contexto customizado para nomenclatura baseado nos inputs passados. Contexto com variáveis padrão ALDO: `region` `component_name` `environment`. Não considera serviços. |
| custom\_context | Contexto customizado para nomenclatura baseado nos inputs passados. Contexto com variáveis do módulo `cloudposse/label/null`. Não considera serviços. |
| custom\_context\_id | String de ID do contexto customizado para nomenclatura baseado nos inputs passados. Não considera serviços. |
<!-- END_TF_DOCS -->