####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Top Level Language Syntax
# Description: In this lab, we demonstrate terraform top level language syntax with input-output 
#              variable(s) & datasource.
####################################################################################################

# terraform required version & providers configuration
terraform {
  required_version = "~> 1.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# input variable for aws region
variable "aws_region" {
  description = "region in which aws resources to be created"
  type = string
  default = "ap-south-1"
}

# input variable for instance type
variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t2.micro"
}

# input variable for Key Pair
variable "instance_keypair" {
  description = "aws ec2 key pair that need to be associated with ec2 instance"
  type = string
  default = "TerraformKeyPair"
}

# cloud i.e. aws provider configuration
provider "aws" {
  region = var.aws_region
  profile = "default"
}

# aws instance resource configuration
resource "aws_instance" "lab-ss-02-03" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = var.instance_type
  key_name = var.instance_keypair
  tags = {
    Name = "lab-ss-02-03"
  }
}

# data source for aws ami 2023
data "aws_ami" "amzlinux2" {
  most_recent = true
  owners = [ "amazon" ]
  filter {
    name = "name"
    values = [ "al2023-ami-*" ]
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

# output variable to verify & display public ip address of created resource i.e. ec2 instance
output "ec2_instance_publicip" {
  description = "ec2 instance public ip"
  value = aws_instance.tftlls.public_ip
}