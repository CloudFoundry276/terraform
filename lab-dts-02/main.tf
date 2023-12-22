########################################################
# Date: 12/21/2023
# Author: Sagar Pitalekar
# Title: Deploy Webserver on AWS Cloud
# Description: In this lab, we write simple terraform 
#               script to deploy apache webserver on 
#               amazon linux 2023 ec2 instance with 
#               aws security group which allow 8080 
#               port for incoming traffic.
########################################################

# provider name registry
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# configure the aws provider
provider "aws" {
  region = "ap-south-1"
}

# create aws ec2 instance
resource "aws_instance" "terraformlab02" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.tfsglab02.id]
  user_data = <<-EOF
              #!/bin/bash
              echo "<h1>Hello World from $(hostname -f)</h1>" > /var/www/html/index.html
              EOF
  
  user_data_replace_on_change = true

  tags = {
    Name = "terraformlab02"
  }
}

resource "aws_security_group" "tfsglab02" {
  name = "tfsglab02"
  description = "allow tls inbound traffic on port 8080"
  ingress {
    description = "allow port 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}