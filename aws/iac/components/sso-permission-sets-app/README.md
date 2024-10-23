# Introdução

Esse repositório é responsável por realizar a configuração de grupos do AD e SSO (agora IAM Identity Center) Permission Sets para acessos de novas aplicações no ambiente AWS. Foi criado um módulo para automatizar e facilitar essa tarefa repetitiva. Para cada aplicação, o módulo sempre criará 2 SSO Permission Sets ( `EDITOR` e `RO` ) e buscará na AWS via `data` as informações dos grupos padrão `GR_AWS_<APP>_RO`, `GR_AWS_<APP>_DEV` e `GR_AWS_<APP>_OWNER`. O serviço AWS SSO (IAM Identity Center) fica na conta de `management` (mesma conta que fica o AWS Control Tower e AWS Organizations). Portanto, é pré-req estar em um grupo do AD com acesso a essa conta para que seja possível a execução do Terraform.

Para entender mais sobre o padrão de acessos para aplicações na AWS, acessar [SSO - Estrutura de Acessos para Aplicações](https://gitlab.anbima.com.br/anbima/cloud/aws/documentation/-/wikis/SSO-(IAM-Identity-Center)-Estrutura-de-Acessos-para-Aplica%C3%A7%C3%B5es)

## Overview de configuração de acessos usando o módulo

Na variável `sso_applications` fica centralizado os acessos que estão/serão criados pelo Terraform. Com o tempo, o tamanho dessa variável irá crescer. Para manipulá-la e adicionar novas aplicações que precisam ter os seus grupos de acesso devidamente configurados, acesse o arquivo `sso.auto.tfvars`.  

A estrutura dela é simples. Ela é um mapa/map de objetos/objects com os atributos `application_tag_key`, `application_tag_values` e `component_name` . O objetivo é a variável ser incrementada com o tempo conforme forem surgindo novos acessos:

```hcl
sso_applications = {

  FEED = {
    application_tag_key    = "Application"
    application_tag_values = ["Feed"]
    component_name         = "feed"
  },
  COCKPIT = {
    application_tag_key    = "Application"
    application_tag_values = ["Cockpit"]
    component_name         = "cockpit"
  }
...
...

  }
```

Abaixo, um breve overview do que significa cada componente:

```hcl
sso_applications = {

  APLICACAO_XPTO = {          # SUFIXO DO NOME DA APLICAÇÃO NO GRUPO - GR_AWS_<APLICACAO>_*
     
    # Application ou BusinessArea - chave da Tag para ser adicionada como restrição na IAM # Policy do acesso de EDITOR.
    application_tag_key    = "Application" 
    
    # Lista de valores para a aplicação - valor da Tag para ser adicionada como restrição na IAM Policy do acesso de EDITOR. 
    #  O módulo utiliza o primeiro valor dessa lista para deixar na descrição padrão do 
    # SSO Permission Sets. As configurações de Tag aplicadas aqui devem ser replicadas 
    # para as Tags dos recursos no projeto de IaC da aplicação.
    # Ex: tags = { 
    #    IAC          = true,
    #    Environment  = "cer",
    #    Application  = "XPTO",
    #    BusinessArea = "Corporativo" 
    #    }

    application_tag_values = ["XPTO"] 

    # `component_name` da aplicação na AWS (naming convention). Usado para dar algumas permissões em serviços como SQS e DynamoDB, baseado no nome do recurso ( sqs-xpto-* , dynamodb-xpto-* ).
    component_name         = "xpto" 
  }
...
...

  }
```

### Como começar?
Para adicionar uma nova aplicação, você precisará:

- Ter os 3 grupos padrão `GR_AWS_*` criados e replicados para a AWS (Importante deixar nome da aplicação no grupo e nos recursos da AWS igual para evitar conflitos de configuração).
- Saber as configurações de Tag para a aplicação.
- Ter acesso na conta de gerenciamento/management.
- Adicionar na variável `sso_applications` a sua aplicação.
Exemplo:

```hcl
sso_applications = {

  FEED = {
    application_tag_key    = "Application"
    application_tag_values = ["Feed"]
    component_name         = "feed" 
  },
  COCKPIT = {
    application_tag_key    = "Application"
    application_tag_values = ["Cockpit"]
    component_name         = "cockpit"
  },
  # NOVA APLICAÇÃO
  SSM = {
    application_tag_key    = "Application"
    application_tag_values = ["SSM"]
    component_name         = "ssm"
  }

  }
```

- Seguir com o workflow do Terraform revisando as adições/changes que serão feitas. A cada nova aplicação adicionada, 18 novos resources serão criados.

# Documentação Padrão Terraform
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
| sso\_applications | Map de aplicações para serem configurados os grupos (GR\_AWS\_<APLICACAO>\_RO , GR\_AWS\_<APLICACAO>\_DEV , GR\_AWS\_<APLICACAO>\_OWNER) e Permissions Sets do SSO. A chave de cada map é a identificação da aplicação no nome dos grupos. Exemplo:<br><br>  sso\_applications =  {<br>    FEED = {<br>      application\_tag\_key    = "Application"<br>      application\_tag\_values = ["Feed"]<br>      component\_name         = "feed"<br>    },<br>    FUNDOS = {<br>      application\_tag\_key    = "Application"<br>      application\_tag\_values = ["Site Fundos","Windows Shared"]<br>      component\_name         = "site-fundos"<br>    }<br>  } | <pre>map(object({<br>    application_tag_key    = string<br>    application_tag_values = list(string)<br>    component_name         = string<br>  }))</pre> | `{}` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->