provider "aws" {
  region = "us-east-1"
}

# SECURITY GROUP

resource "aws_security_group" "mi_sg_windows" {
  name        = "mi-security-group-windows"
  description = "Permitir acceso RDP y HTTP"
  vpc_id      = "vpc-0c2f784562003c0df"

  # Acceso remoto a Windows (RDP)
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso remoto RDP"
  }

  # Acceso HTTP
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Acceso HTTP"
  }

  # Trafico saliente
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "SG-Windows-Terraform"
  }
}

# INSTANCIA EC2 WINDOWS SERVER

resource "aws_instance" "mi_instancia_windows" {
  ami           = "ami-0b5f645abc199e666"
  instance_type = "t3.micro"

  key_name = "mi-primera-llave-sa"

  vpc_security_group_ids = [
    aws_security_group.mi_sg_windows.id
  ]

  tags = {
    Name = "MiInstanciaWindowsTerraform"
  }
}
