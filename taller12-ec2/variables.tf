#Region donde se desplegaran los recursos
variable "region" {
  description = "Region donde se desplegaran los recursos"
  type        = string
  default     = "us-east-1"
}

variable "ami_id" {
  description = "ID de la imagen de Amazon Linux 2"
  type        = string
  default     = "ami-0c230065b91270bc6"
}

variable "tipo_instancia" {
  description = "Tipo de instancia"
  type        = string
  default     = "t2.micro"
}

variable "nombre_llave" {
  description = "Nombre de la clave SSH para acceder a la instancia"
  type        = string
  default     = "mi-primera-llave-sa"
}

variable "cantidad_instancias" {
  description = "Cantidad de instancias a crear"
  type        = number
  default     = 2
}
