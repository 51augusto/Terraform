################################################################################
# Custom context
################################################################################

output "custom_context" {
  value       = module.custom.context
  description = "Contexto customizado para nomenclatura baseado nos inputs passados. Contexto com variáveis do módulo `cloudposse/label/null`. Não considera serviços."
}

output "anbima_context" {
  value       = local.anbima_context
  description = "Contexto customizado para nomenclatura baseado nos inputs passados. Contexto com variáveis padrão ANBIMA: `region` `component_name` `environment`. Não considera serviços."
}

output "custom_context_id" {
  value       = module.custom.id
  description = "String de ID do contexto customizado para nomenclatura baseado nos inputs passados. Não considera serviços."
}