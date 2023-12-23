########################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Create EC2 Instance & Provision Webserver
# Description: In this lab, we write simple terraform 
#               script to create aws ec2 instance & 
#               provision a webserver with userdata.
########################################################

# provide name registry
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
  profile = "default"
}

# create aws ec2 instance
resource "aws_instance" "app1ec2vm" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  user_data = file("${path.module}/app1-install.sh")
  tags = {
    Name = "EC2 Demo"
  }
}