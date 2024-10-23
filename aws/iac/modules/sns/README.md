<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| this | git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.app_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_sns_topic.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic) | resource |
| [aws_sns_topic_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/sns_topic_policy) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome do tópico SNS. | `string` | n/a | yes |
| content\_based\_deduplication | Habilta o content-based deduplication para quando o tópico for FIFO. <br><br>  Ref: https://docs.aws.amazon.com/sns/latest/dg/fifo-message-dedup.html | `bool` | `false` | no |
| create\_app\_policy | Indica se deve criar a política de acesso para aplicações. | `bool` | `false` | no |
| delivery\_policy | Política de entrega do tópico customizada. Se não atribuída, é configurada uma política default. | `map(any)` | `null` | no |
| fifo | Define se o tópico é FIFO | `bool` | `false` | no |
| kms\_key | ID/alias de chave KMS customizada. Caso não seja passado um valor, é utilizada a chave KMS padrão da AWS | `string` | `null` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| topic\_policy | Statements adicionais para a política de acesso do tópico. Se não atribuída, é configurada uma política default.<br><br>  topic\_policy = [<br>    {<br>        Sid    = "SnsStatement"<br>        Effect = "Allow",<br>        Principal = {<br>          AWS = "arn:aws:iam::<ACCOUNT\_ID>:role/role-sns-publisher"<br>        },<br>        Action = [<br>          "SNS:Subscribe",<br>          "SNS:SetTopicAttributes",<br>          "SNS:RemovePermission",<br>          "SNS:Receive",<br>          "SNS:Publish",<br>          "SNS:ListSubscriptionsByTopic",<br>          "SNS:GetTopicAttributes",<br>          "SNS:DeleteTopic",<br>          "SNS:AddPermission"<br>        ]<br><br>        Resource = ["arn:aws:sns:us-east-1:<ACCOUNT\_ID>:sns-topic"]<br>      }<br>  ] | `list(any)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_policy | Política de acesso para aplicações. |
| topic | Tópico SNS |
<!-- END_TF_DOCS -->