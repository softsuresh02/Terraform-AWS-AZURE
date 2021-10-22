terraform {
  required_providers {
    aws = {
      source = "Hashicorp/aws"


    }
  }
}

provider "aws" {

  profile = "default"

  region = "us-east-1"

}

resource "aws_instance" "ec2demo" {

  ami                    = "ami-0416f96ae3d1a3f29"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
}

resource "aws_security_group" "vpc-ssh" {
  name        = "vpc-ssh"
  description = "Dev vpc SSH"

  ingress {
    description = "Allow Port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow All IP and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "vpc-ssh"
  }
}
resource "aws_security_group" "vpc-web" {
  name        = "vpc-web"
  description = "Dev vpc web"

  ingress {
    description = "Allow Port 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow All IP and ports outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "vpc-web"
  }
}