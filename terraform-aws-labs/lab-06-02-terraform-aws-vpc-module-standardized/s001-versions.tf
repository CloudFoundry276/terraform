# terraform block
terraform {
  required_version = "~> 1"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5"
    }
  }
}

# provider block
provider "aws" {
  region = var.aws_region
  profile = "default"
}