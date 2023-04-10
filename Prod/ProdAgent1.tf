provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "Prod-1" {
  ami = "ami-007855ac798b5175e"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_builder1.id]
  associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt -y install default-jdk
sudo apt -y install docker.io
sudo apt -y install mc
EOF
}

resource "aws_security_group" "my_builder1" {
  name = "Builder Security Group"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}