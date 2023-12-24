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
  region = "us-east-1"
  profile = "default"
}
