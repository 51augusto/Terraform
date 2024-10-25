<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.app_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_sqs_queue.dlq](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |
| [aws_sqs_queue.queue](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sqs_queue) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome da fila SQS. | `string` | n/a | yes |
| content\_based\_deduplication | Configura deduplicação das SQS padrão false | `bool` | `false` | no |
| create\_app\_policy | Indica se deve criar a política de acesso para aplicações. | `bool` | `false` | no |
| delay\_seconds | Tempo de delay da fila SQS em segundos | `number` | `0` | no |
| dlq\_message\_retention\_seconds | Tempo de retenção das menssagens na DLQ (padrão 14 dias) | `number` | `1209600` | no |
| dlq\_visibility\_timeout\_seconds | Timeout de visibilidade padrão da mensagem na DLQ | `number` | `30` | no |
| fifo | Define se a fila é FIFO | `bool` | `false` | no |
| max\_message\_size | Tamanho maximo das messagens no SQS | `number` | `2048` | no |
| max\_receive\_count | Numero máximo de retentativas antes da mensagem ser enviada à DLQ | `number` | `4` | no |
| message\_retention\_seconds | Tempo de retenção das menssagens no SQS (padrão 7 dias) | `number` | `604800` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| visibility\_timeout\_seconds | Timeout de visibilidade padrão da mensagem | `number` | `30` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_policy | Política de acesso para aplicações. |
| dlq | Fila SQS DLQ |
| queue | Fila SQS principal |
<!-- END_TF_DOCS -->