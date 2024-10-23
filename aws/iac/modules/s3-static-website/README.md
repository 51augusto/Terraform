<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.5 |
| aws | >= 5.0.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| bucket | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git | main |
| bucket\_logs | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/s3.git | main |
| this | git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/naming-convention.git | main |
| website | terraform-aws-modules/cloudfront/aws | 3.2.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.cicd_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_s3_bucket_policy.bucket_logs_oai_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_policy.bucket_oai_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| aliases | Listas de aliases do Website. | `list(string)` | n/a | yes |
| certificate\_arn | ARN do certificado do ACM para ser utilizado pelo Website. | `string` | n/a | yes |
| component\_name | Nome do componente. Exemplo: `SSM`, `GAO`, `FUNDOS`, `CORP`, `SHARED` | `string` | n/a | yes |
| environment | Ambiente. Valores permitidos: `dev`, `cer`, `hml` , `prd`, `shared`, `network`, `logs`, `audit`, `backup`, `sandbox` | `string` | n/a | yes |
| name | Nome do Website. | `string` | n/a | yes |
| allowed\_methods | Lista de métodos permitidos no cache behavior default. Ex: GET, HEAD, OPTIONS | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD",<br>  "OPTIONS"<br>]</pre> | no |
| bucket\_cors\_rules | Regras de cors que serão aplicadas no bucket criado. | <pre>list(object({<br>    allowed_headers = list(string)<br>    allowed_methods = list(string)<br>    allowed_origins = list(string)<br>    expose_headers  = list(string)<br>    max_age_seconds = number<br>  }))</pre> | `[]` | no |
| bucket\_expiration\_rules | Regras de expiração de objetos do bucket. | <pre>list(object({<br>    prefix : string,<br>    days : number<br>  }))</pre> | `[]` | no |
| cache\_policy\_id | Id da cache policy que será utilizada no Default Cache Beheavior | `string` | `null` | no |
| cached\_methods | Lista de métodos permitidos de cache no cache behavior default. Ex: GET, HEAD | `list(string)` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| compress | Determina se os arquivos serão comprimidos em formato gzip | `bool` | `true` | no |
| create\_bucket\_app\_policy | Indica se deve criar a política de acesso para aplicações no buckets. | `bool` | `false` | no |
| create\_cicd\_policy | Indica se deve criar a política de acesso para CI/CD. | `bool` | `false` | no |
| custom\_error\_pages | Páginas de erro customizadas do Website. Ex.: `404 = "/index.html"`. | `map(any)` | `{}` | no |
| custom\_error\_response | Páginas de erro customizadas do Website e seus respectivos return codes. | `list(any)` | `null` | no |
| default\_root\_file | Arquivo raiz padrão do Website. | `string` | `"index.html"` | no |
| default\_ttl | TTL em segundos padrão para caching das páginas do Website. | `number` | `3600` | no |
| enable\_access\_logs | Indica se o website terá logs de acesso armazenados em um bucket S3. | `bool` | `false` | no |
| error\_caching\_min\_ttl | TTL em segundos para caching das páginas de erro do Website. | `number` | `300` | no |
| forward\_query\_string | Indica se é para incluir todos query strings na chave do cache. | `bool` | `false` | no |
| function\_association | Associações de funções CloudFront para o Cache Behaviour. | `map(any)` | `{}` | no |
| include\_cookies\_for\_access\_logs | Indica se deve incluir os cookies nos logs de acesso armazenados. | `bool` | `false` | no |
| lambda\_function\_association | Associações de funções Lambda@Edge para o Cache Behaviour. | `map(any)` | `{}` | no |
| max\_ttl | TTL em segundos padrão para caching das páginas do Website. | `number` | `86400` | no |
| min\_ttl | TTL em segundos mínimo para caching das páginas do Website. | `number` | `300` | no |
| minimum\_protocol\_version | Versão mínima do protocolo de SSL que será suportada pelo Website: https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/secure-connections-supported-viewer-protocols-ciphers.html. | `string` | `"TLSv1.2_2021"` | no |
| ordered\_cache\_behavior | Regras de cache behavior para serem utilizadas além da padrão. | `list(any)` | `[]` | no |
| origin\_custom\_headers | Cloudfront incluirá esses headers em todas as requisições que enviará para sua origin | <pre>list(object({<br>    name  = string<br>    value = string<br>  }))</pre> | `[]` | no |
| price\_class | Classe de preço do Website. Possíveis valores: PriceClass\_All, PriceClass\_200, PriceClass\_100 | `string` | `"PriceClass_100"` | no |
| region | Região AWS. | `string` | `"us-east-1"` | no |
| response\_headers\_policy\_id | Id da response header policy que será utilizada no Default Cache Beheavior | `string` | `null` | no |
| use\_forwarded\_values | Indica se deve usar o fowarded values no default cache behavior. | `bool` | `true` | no |
| waf\_acl\_arn | ARN da ACL do WAF para ser utilizada no Website. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| bucket | Bucket de conteúdo do Website. |
| cicd\_policy | Política de acesso para CI/CD. |
| website | Website no CloudFront. |
<!-- END_TF_DOCS -->