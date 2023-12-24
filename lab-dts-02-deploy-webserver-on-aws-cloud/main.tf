####################################################################################################
# Date: 12/25/2023
# Author: Sagar Pitalekar
# Title: Terraform Deploy Apache Webserver on AWS Cloud
# Description: In this lab, we demonstrate how to deploy apache webserver on aws ec2 instance i.e. 
#              aws cloud.
####################################################################################################

# providers version configuration - terraform registry
terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# configure aws provider
provider "aws" {
  region = "ap-south-1"
  profile = "default"
}

# configure aws security group
resource "aws_security_group" "labdts02-web" {
  name = "labdts02-web"
  ingress {
    description = "allow port 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "labdts02-custom" {
  name = "labdts02-custom"
  ingress {
    description = "allow port 8080"
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# configure aws ec2 instance
resource "aws_instance" "labdts02" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.labdts02-web.id, aws_security_group.labdts02-custom.id]
  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl enable httpd
  sudo service httpd start
  sudo echo '<h1>Welcome to Terraform Apache Demo</h1>' | sudo tee /var/www/html/index.html
  sudo mkdir /var/www/html/app
  sudo echo '<!DOCTYPE html> <html> <body style="background-color: rgb(211, 211, 211);"> <h1>Welcome to Terraform Apache Demo</h1> <p>application version: 1.0.0</p> </body> </html>' | sudo tee /var/www/html/app/index.html
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "labdts02"
  }
}