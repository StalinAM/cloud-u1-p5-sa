#Configuracion del proveedor de AWS
provider "aws" {
  region = "us-east-1" #region donde se desplegaran los recursos
}

#Creamos el security group para permitir el acceso SSH a la instancia
resource "aws_security_group" "mi_sg" {
  name        = "mi-security-group-terraform" #Nombre del security group
  description = "Permitir acceso SSH" #Descripcion del security group
  vpc_id      = "vpc-0c2f784562003c0df" #ID del VPC donde se creara el security group

  #reglas de entrada para permitir el acceso SSH desde cualquier dirección IP
  ingress {
    from_port   = 22 #Puerto de entrada para SSH
    to_port     = 22 #Puerto de salida para SSH
    protocol    = "tcp" #Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] #Permitir acceso desde cualquier dirección IP
  }
  ingress {
    from_port   = 80 #Puerto de entrada para HTTP
    to_port     = 80 #Puerto de salida para HTTP
    protocol    = "tcp" #Protocolo TCP
    cidr_blocks = ["0.0.0.0/0"] #Permitir acceso desde cualquier dirección IP
  }
  #reglas de salida para permitir todo el tráfico saliente
  egress {
    from_port   = 0 #Puerto de inicio para el tráfico saliente
    to_port     = 0 #Puerto final para el tráfico saliente
    protocol    = "-1" #Permitir todo el tráfico
    cidr_blocks = ["0.0.0.0/0"] #Permitir tráfico desde cualquier dirección IP
  }
}

#Declaracion de los recursos de AWS
resource "aws_instance" "mi_instancia_2" {
  ami           = "ami-0c230065b91270bc6" #ID de la imagen de Amazon Linux 2
  instance_type = "t2.micro" #Tipo de instancia
  key_name      = "mi-primera-llave-sa" #Nombre de la clave SSH para acceder a la instancia
  security_groups = [aws_security_group.mi_sg.name] #Asociamos el security group creado anteriormente a la instancia
  tags = {
    Name = "MiInstanciaTerraform2" #Etiqueta para identificar la instancia
  }
  vpc_security_group_ids = [aws_security_group.mi_sg.id] #Asociamos el security group creado anteriormente a la instancia
}
