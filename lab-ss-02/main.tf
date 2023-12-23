########################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Variables & Datasources
# Description: In this lab, we write simple terraform 
#               script to demonstrate variables &  
#               datasources.
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
  region = var.aws_region
  profile = "default"
}

# ec2 instance
resource "aws_instance" "labss02" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app2-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  tags = {
    Name = "Lab SS 02"
  }
}