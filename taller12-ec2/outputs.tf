output "ids_instancias" {
  description = "IDs de las instancias creadas"
  value       = aws_instance.mi_instancia_efs[*].id
}
output "cantidad_instancias" {
  description = "Cantidad de instancias creadas"
  value       = length(aws_instance.mi_instancia_efs)
}

output "ip_publica_instancias" {
  description = "Direcciones IP públicas de las instancias creadas"
  value       = aws_instance.mi_instancia_efs[*].public_ip
}

output "zonas_disponibilidad_instancias" {
  description = "Zonas de disponibilidad de las instancias creadas"
  value       = aws_instance.mi_instancia_efs[*].availability_zone
}
