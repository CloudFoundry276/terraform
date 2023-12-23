####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Top Level Language Syntax
# Description: In this lab, we demonstrate terraform top level language syntax with input-output 
#              variable(s) & datasource.
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

# aws region variable
variable "aws_region" {
  description = "region in which aws resources to be created"
  type = string
  default = "ap-south-1"
}

# variable aws ec2 instance type
variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t2.micro"
}

# variable aws ec2 instance key pair
variable "instance_keypair" {
  description = "aws ec2 key pair that need to be associated with ec2 instance"
  type = string
  default = "TerraformKeyPair"
}

# configure aws provider
provider "aws" {
  region = var.aws_region
  profile = "default"
}

# configure aws ec2 instance
resource "aws_instance" "tftlls" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = var.instance_type
  key_name = var.instance_keypair
  tags = {
    Name = "TerraformTopLevelLanguageSyntax"
  }
}

# fetch/get latest ami id for amazon linux 2 os
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "amzn2-ami-hvm-*" ]
  }
  filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
  filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

# terraform output values
output "ec2_instance_publicip" {
  description = "ec2 instance public ip"
  value = aws_instance.tftlls.public_ip
}