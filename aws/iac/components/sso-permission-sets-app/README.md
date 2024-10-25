<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 1.5 |
| aws | ~> 5.0 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| sso\_app | git::git@gitlab.anbima.com.br:anbima/cloud/aws/iac/modules/sso-app-permission-sets.git | main |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| sso\_applications | Map de aplicações para serem configurados os grupos (GR\_AWS\_<APLICACAO>\_RO , GR\_AWS\_<APLICACAO>\_DEV , GR\_AWS\_<APLICACAO>\_OWNER) e Permissions Sets do SSO. A chave de cada map é a identificação da aplicação no nome dos grupos. Exemplo:<br/><br/>  sso\_applications =  {<br/>    FEED = {<br/>      application\_tag\_key    = "Application"<br/>      application\_tag\_values = ["Feed"]<br/>      component\_name         = "feed"<br/>    },<br/>    FUNDOS = {<br/>      application\_tag\_key    = "Application"<br/>      application\_tag\_values = ["Site Fundos","Windows Shared"]<br/>      component\_name         = "site-fundos"<br/>    }<br/>  } | <pre>map(object({<br/>    application_tag_key    = string<br/>    application_tag_values = list(string)<br/>    component_name         = string<br/>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->