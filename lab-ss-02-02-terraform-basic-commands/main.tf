####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Basic Commands
# Description: In this lab, we demonstrate terraform basic commands to create single ec2 instance.
####################################################################################################

# providers version configuration
terraform {
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
resource "aws_instance" "TerraformBasicCommands" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  tags = {
    Name = "TerraformBasicCommands"
  }
}