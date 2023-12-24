####################################################################################################
# Date: 12/24/2023
# Author: Sagar Pitalekar
# Title: Terraform Provision EC2 Instance
# Description: In this lab, we demonstrate ec2 instance provision using terraform.
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

# configure aws ec2 instance
resource "aws_instance" "labdts01" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  tags = {
    Name = "labdts01"
  }
}