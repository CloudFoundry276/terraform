########################################################
# Date: 12/21/2023
# Author: Sagar Pitalekar
# Title: Create EC2 Instance using Terraform
# Description: In this lab, we write simple terraform 
#               script to create aws ec2 instance.
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
resource "aws_instance" "example" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"

  tags = {
    Name = "terraformlab01"
  }
}