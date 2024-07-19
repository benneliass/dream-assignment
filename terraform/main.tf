provider "aws" {
  region = var.region
}

provider "random" {
  version = ">= 2.0"
}

resource "random_string" "Instance_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "generated_key" {
  key_name   = "key-pair-${random_string.Instance_suffix.result}"
  public_key = tls_private_key.private_key.public_key_openssh
}

resource "aws_instance" "flask_app" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update -y
              apt-get install -y docker.io
              systemctl start docker
              systemctl enable docker

              # Login to DockerHub
              echo "${var.dockerhub_token}" | docker login -u "${var.dockerhub_username}" ${var.dockerhub_registry} --password-stdin

              # Run the Docker container
              docker run -d -p ${var.app_port}:${var.app_port} ${var.dockerhub_registry}/${var.dockerhub_username}/${var.dockerhub_repository}:${var.dockerhub_tag}
              EOF

  key_name = aws_key_pair.generated_key.key_name

  # Security group
  vpc_security_group_ids = [aws_security_group.flask_sg.id]

}

resource "aws_security_group" "flask_sg" {
  name        = "flask_sg-${random_string.Instance_suffix.result}"
  description = "Allow HTTP and SSH traffic"

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}