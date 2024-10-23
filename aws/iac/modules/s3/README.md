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
| [aws_s3_bucket.bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_cors_configuration.bucket_cors](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_cors_configuration) | resource |
| [aws_s3_bucket_lifecycle_configuration.bucket_lifecycle](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_lifecycle_configuration) | resource |
| [aws_s3_bucket_object_lock_configuration.object_lock](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_object_lock_configuration) | resource |
| [aws_s3_bucket_ownership_controls.bucket_ownership](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_ownership_controls) | resource |
| [aws_s3_bucket_policy.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.bucket_public_access_block](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.bucket_sse](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.bucket_versioning](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome do bucket. | `string` | n/a | yes |
| cors\_rules | Regras de cors que serão aplicada. | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    max_age_seconds = number<br>  }))</pre> | `[]` | no |
| create\_app\_policy | Indica se deve criar a política de acesso para aplicações. | `bool` | `false` | no |
| dr\_backup | Habilita o DR Backup | `bool` | `false` | no |
| expiration\_rules | Regras de expiração de objetos do bucket. | <pre>list(object({<br>    prefix : string,<br>    days : number<br>  }))</pre> | `[]` | no |
| noncurr\_expiration\_rules | Regras de expiração de versões não atuais de objetos do bucket. | <pre>list(object({<br>    prefix : string,<br>    days : number<br>  }))</pre> | `[]` | no |
| noncurr\_transition\_rules | Regras de transição de Storage Class de versões não atuais de objetos do bucket. | <pre>list(object({<br>    prefix : string,<br>    days : number,<br>    storage_class : string<br>  }))</pre> | `[]` | no |
| object\_lock\_configuration | Mode: Modo de retenção do Object Lock padrão que você deseja aplicar a novos objetos armazenados no bucket especificado. Valores válidos: GOVERNANCE , COMPLIANCE<br>  Para utilizar esse modo é necessario que o versioning do bucket precisa estar enabled: versioning = "Enabled"<br><br>  - Governance: objeto fica impossibilitado de ser deletado após o período determinado, porém uma<br>  identidade IAM com algumas permissões específicas de S3 ainda consegue fazer um bypass dessa configuração.<br><br>  - Compliance: objeto fica impossibilitado de ser deletado após o período determinado. <br>  Nenhum usuário, incluindo o Root, consegue deletar os arquivos durante o período de retenção configurado. | <pre>object({<br>    days = number<br>    mode = string<br>  })</pre> | `null` | no |
| public\_bucket | Expõe o bucket para toda a internet. Habilitar APENAS em casos necessários. Necessário usar a criptografia SSE-S3. | `bool` | `false` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| sse\_type | Tipo de encriptação Server-Side a ser utilizada. Valores permitidos: `SSE-KMS` e `SSE-S3`. Ref.: https://docs.aws.amazon.com/AmazonS3/latest/userguide/serv-side-encryption.html | `string` | `"SSE-KMS"` | no |
| transition\_rules | Regras de transição de Storage Class de objetos do bucket. | <pre>list(object({<br>    prefix : string,<br>    days : number,<br>    storage_class : string<br>  }))</pre> | `[]` | no |
| versioning | Habilita versionamento de objetos no bucket, valores válidos: `Enabled`, `Suspended` ou `Disabled`. | `string` | `"Disabled"` | no |

## Outputs

| Name | Description |
|------|-------------|
| app\_policy | Política de acesso para aplicações. |
| bucket | Bucket |
<!-- END_TF_DOCS -->
