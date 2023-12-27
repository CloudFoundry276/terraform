####################################################################################################
# Date: 12/27/2023
# Author: Sagar Pitalekar
# Title: Terraform EC2 Instance Creation
# Description: In this lab, we demonstrate ec2 instance creation using terraform.
####################################################################################################

# configure terraform version & required provider
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

# configure aws ec2 instance creation
resource "aws_instance" "labiam01" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  tags = {
    Name = "labiam01"
  }
}