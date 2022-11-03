provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "my_webserver2" {
  ami = "ami-0caef02b518350c8b"
  instance_type = "t2.medium"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]
  user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt -y install docker.io
EOF
}

//sudo apt install openjdk-8-jre-headless
//sudo apt -y install maven
//git clone https://github.com/mvolkov82/boxfuse-sample-java-war-hello.git
//cd boxfuse-sample-java-war-hello
//mvn package

resource "aws_security_group" "my_webserver" {
  name        = "WebServer Security Group"
  description = "Allow TLS inbound traffic"

  ingress {
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}