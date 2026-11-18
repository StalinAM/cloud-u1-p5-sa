#Configuracion del proveedor de AWS
provider "aws" {
  region = var.region #region donde se desplegaran los recursos
}

#Creamos el security group para permitir el acceso SSH a la instancia
resource "aws_security_group" "mi_sg_efs_instancias" {
  name        = "mi-security-group-terraform-instancias" #Nombre del security group
  description = "Permitir acceso SSH"                    #Descripcion del security group
  vpc_id      = "vpc-0c2f784562003c0df"                  #ID del VPC donde se creara el security group

  #reglas de entrada para permitir el acceso SSH desde cualquier dirección IP
  ingress {
    from_port   = 22            #Puerto de entrada para SSH
    to_port     = 22            #Puerto de salida para SSH
    protocol    = "tcp"         #Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] #Permitir acceso desde cualquier dirección IP
  }
  #reglas de salida para permitir todo el tráfico saliente
  egress {
    from_port   = 0             #Puerto de inicio para el tráfico saliente
    to_port     = 0             #Puerto final para el tráfico saliente
    protocol    = "-1"          #Permitir todo el tráfico
    cidr_blocks = ["0.0.0.0/0"] #Permitir tráfico desde cualquier dirección IP
  }
  #reglas de salida para permitir todo el tráfico saliente
  egress {
    from_port   = 2049          #Puerto de inicio para el tráfico saliente
    to_port     = 2049          #Puerto final para el tráfico saliente
    protocol    = "tcp"         #Permitir todo el tráfico
    cidr_blocks = ["0.0.0.0/0"] #Permitir tráfico desde cualquier dirección IP
  }
}

resource "aws_security_group" "mi_sg_efs" {
  name        = "mi-security-group-terraform-efs" #Nombre del security group
  description = "Permitir acceso SSH"             #Descripcion del security group
  vpc_id      = "vpc-0c2f784562003c0df"           #ID del VPC donde se creara el security group

  #reglas de entrada para permitir el acceso SSH desde cualquier dirección IP
  ingress {
    from_port   = 22            #Puerto de entrada para SSH
    to_port     = 22            #Puerto de salida para SSH
    protocol    = "tcp"         #Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] #Permitir acceso desde cualquier dirección IP
  }
  ingress {
    from_port   = 2049          #Puerto de entrada para HTTP
    to_port     = 2049          #Puerto de salida para HTTP
    protocol    = "tcp"         #Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] #Permitir acceso desde cualquier dirección IP
  }
  #reglas de salida para permitir todo el tráfico saliente
  egress {
    from_port   = 0             #Puerto de inicio para el tráfico saliente
    to_port     = 0             #Puerto final para el tráfico saliente
    protocol    = "-1"          #Permitir todo el tráfico
    cidr_blocks = ["0.0.0.0/0"] #Permitir tráfico desde cualquier dirección IP
  }
}
#Declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_efs" {
  ami             = var.ami_id                                     #ID de la imagen de Amazon Linux 2
  instance_type   = var.tipo_instancia                             #Tipo de instancia
  key_name        = var.nombre_llave                               #Nombre de la clave SSH para acceder a la instancia
  security_groups = [aws_security_group.mi_sg_efs_instancias.name] #Asociamos el security group creado anteriormente a la instancia
  count           = var.cantidad_instancias                        #Cantidad de instancias a crear
  tags = {
    Name = "Mi intancia efs ${count.index + 1}" #Etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi_sg_efs_instancias.id] #Asociamos el security group creado anteriormente a la instancia
}

