provider "aws" {
  region = "eu-central-1"
}

resource "aws_instance" "builder" {
  ami = "ami-0caef02b518350c8b"
  instance_type = "t3.medium"
  vpc_security_group_ids = [aws_security_group.my_builder1.id]
  associate_public_ip_address = true
  user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo apt -y install docker.io
sudo apt -y install mc
mkdir -p /opt/java_project
cd /opt/java_project
git clone https://github.com/mvolkov82/boxfuse-sample-java-war-hello.git
cd boxfuse-sample-java-war-hello
docker run --rm --name my-maven-project -v "$(pwd)":/usr/src/mymaven -w /usr/src/mymaven maven:3.3-jdk-8 mvn clean install
cd target
docker run --rm -e AWS_ACCESS_KEY_ID=${var.key_id} -e AWS_SECRET_ACCESS_KEY=${var.key} amazon/aws-cli s3 mb s3://malvolkov05
echo "---------------------------------"
ls -la
echo "$(pwd)"
echo "---------------------------------"
docker run --rm -e AWS_ACCESS_KEY_ID=${var.key_id} -e AWS_SECRET_ACCESS_KEY=${var.key} amazon/aws-cli s3 cp /opt/java_project/boxfuse-sample-java-war-hello/target/hello-1.0.war s3://malvolkov05
EOF
}

//resource "aws_instance" "aws_sender" {
//  ami = "ami-0caef02b518350c8b"
//  instance_type = "t2.micro"
//  vpc_security_group_ids = [aws_security_group.my_builder1.id]
//  user_data = <<EOF
//#!/bin/bash
//sudo apt -y update
//sudo apt -y install docker.io
//sudo apt -y install mc
//mkdir -p /opt/java_artifact
//cd /opt/java_artifact
//
//docker run --rm -ti -v a2:/artifact -v ~/.aws:/root/.aws -v $(pwd):/aws amazon/aws-cli s3 cp s3://aws-cli-docker-demo/hello .
//
//docker build -t maven_builder .
//docker volume create --name a2
//docker run -v /var/run/docker.sock:/var/run/docker.sock -v a2:/artifact maven_builder
//EOF
//}


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