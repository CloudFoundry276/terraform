####################################################################################################
# Date: 01/01/2024
# Author: Sagar Pitalekar
# Title: Terraform Modules
# Description: In this lab, we demonstrate terraform modules & it's usage.
####################################################################################################

# configure terraform version & required providers
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
}

# configure ec2 instance module
module "ec2-instance" {
  source = "./modules/ec2-instance"
  ami_value = "ami-0a0f1259dd1c90938"
  instance_type_value = "t2.micro"
  subnet_id_value = "subnet-010a525708e63475d"
}