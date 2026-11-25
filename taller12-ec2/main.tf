#Configuracion del proveedor de AWS
provider "aws" {
  region = var.region #region donde se desplegaran los recursos
}

#Creamos el security group para permitir el acceso SSH a la instancia
resource "aws_security_group" "mi_sg_efs_instancias_14" {
  name        = "mi-security-group-terraform-instancias" #Nombre del security group
  description = "Permitir acceso SSH"                    #Descripcion del security group
  vpc_id      = "vpc-0c2f784562003c0df"                  #ID del VPC donde se creara el security group

}

resource "aws_security_group" "mi_sg_efs_14" {
  name        = "mi-security-group-terraform-efs" #Nombre del security group
  description = "Permitir acceso SSH"             #Descripcion del security group
  vpc_id      = "vpc-0c2f784562003c0df"           #ID del VPC donde se creara el security group

}
#Reglas de entrada SG Instancias
resource "aws_vpc_security_group_ingress_rule" "regla_ssh_instancias" {
  security_group_id = aws_security_group.mi_sg_efs_instancias_14.id
  from_port         = 22
  to_port           = 22
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
}

#Reglas de salida SG Instancias
resource "aws_vpc_security_group_egress_rule" "regla_salida_instancias" {
  security_group_id = aws_security_group.mi_sg_efs_instancias_14.id
  from_port         = 2049
  to_port           = 2049
  ip_protocol       = "tcp"
  #destino
  referenced_security_group_id = aws_security_group.mi_sg_efs_14.id
}

resource "aws_vpc_security_group_egress_rule" "regla_salida_internet" {
  security_group_id = aws_security_group.mi_sg_efs_instancias_14.id
  ip_protocol       = "-1"
  #destino
  cidr_ipv4 = "0.0.0.0/0"
}
#Reglas de entrada SG EFS
resource "aws_vpc_security_group_ingress_rule" "regla_efs" {
  security_group_id = aws_security_group.mi_sg_efs_14.id
  from_port         = 2049
  to_port           = 2049
  ip_protocol       = "tcp"
  #origen
  referenced_security_group_id = aws_security_group.mi_sg_efs_instancias_14.id
}

#Declaracion de los recursos de AWS
# resource "aws_instance" "mi_instancia_efs" {
#   ami             = var.ami_id                                     #ID de la imagen de Amazon Linux 2
#   instance_type   = var.tipo_instancia                             #Tipo de instancia
#   key_name        = var.nombre_llave                               #Nombre de la clave SSH para acceder a la instancia
#   security_groups = aws_security_group.mi_sg_efs_instancias_14.name #Asociamos el security group creado anteriormente a la instancia
#   count           = var.cantidad_instancias                        #Cantidad de instancias a crear
#   tags = {
#     Name = "Mi intancia efs ${count.index + 1}" #Etiqueta para identificar la instancia
#   }
#   vpc_security_group_ids = aws_security_group.mi_sg_efs_instancias_14.id #Asociamos el security group creado anteriormente a la instancia
# }

