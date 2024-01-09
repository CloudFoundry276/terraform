####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Basic Commands
# Description: In this lab, we demonstrate terraform basic commands to create single ec2 instance.
####################################################################################################

# terraform required providers configuration
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# cloud i.e. aws provider configuration
provider "aws" {
  region = "ap-south-1"
  profile = "default"
}

# aws instance resource configuration
resource "aws_instance" "lab-ss-02-02" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  tags = {
    Name = "lab-ss-02-02"
  }
}