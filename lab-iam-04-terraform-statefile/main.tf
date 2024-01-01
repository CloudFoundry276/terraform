####################################################################################################
# Date: 01/01/2024
# Author: Sagar Pitalekar
# Title: Terraform Statefile
# Description: In this lab, we demonstrate terraform statefile.
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

# configure aws ec2 instance
resource "aws_instance" "labiam04-ec2" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  subnet_id = "subnet-010a525708e63475d"
}

# configure aws s3 bucket
resource "aws_s3_bucket" "labiam04-s3bucket" {
  bucket = "labiam04-s3bucket"
}

# configure aws dynamodb table
resource "aws_dynamodb_table" "labiam04-dynamodb" {
  name = "labiam04-dynamodb"
  billing_mode = "PAY_PER_REQUEST"
  hash_key = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}