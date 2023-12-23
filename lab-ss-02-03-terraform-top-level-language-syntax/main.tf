####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Top Level Language Syntax
# Description: In this lab, we demonstrate terraform top level language syntax, in which we store 
#              terraform state file into s3 bucket & lock it into dynamodb with input-output 
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

  # add s3 bucket in backend to store terraform state file & lock it into dynamodb table
  backend "s3" {
    bucket = "tfstate-bucket"
    key = "terraform.tfstate"
    region = "ap-south-1"
    dynamodb_table = "tbl_tfstate"
  }
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
  tags = {
    Name = "TerraformTopLevelLanguageSyntax"
  }
}

# create s3 bucket with input variable(s) & local value(s)
locals {
  bucket-name-prefix = "${var.app_name}-${var.env_name}"
}

# fetch/get latest ami id for amazon linux 2 os
data "aws_ami" "amzlinux" {
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