output "route_53_zone_ext_name" {
  value       = try(aws_route53_zone.ext[0].name, "")
  description = "Nome da zona pública."
}

output "route_53_zone_int_name" {
  value       = try(aws_route53_zone.int[0].name, "")
  description = "Nome da zona privada."
}

output "route_53_zone_ext_id" {
  value       = try(aws_route53_zone.ext[0].id, "")
  description = "ID da zona pública."
}

output "route_53_zone_int_id" {
  value       = try(aws_route53_zone.int[0].id, "")
  description = "ID da zona privada."
}