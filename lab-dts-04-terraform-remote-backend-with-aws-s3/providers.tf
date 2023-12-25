# providers version configuration - terraform registry
terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # s3 backend
  backend "s3" {
    bucket = "labdts04s3bucket"
    key = "global/s3/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "labdts04s3buckettbl"
    encrypt = true
  }
}

# configure aws provider
provider "aws" {
  region = var.aws_region
  profile = "default"
}