####################################################################################################
# Date: 01/02/2024
# Author: Sagar Pitalekar
# Title: Terraform Secure Vault
# Description: In this lab, we demonstrate terraform security with terraform vault.
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

# configure vault provider
provider "vault" {
  address = "http://127.0.0.1:8200"
  skip_child_token = true
  auth_login {
    path = "auth/approle/login"
    parameters = {
      role_id = "<>"
      secret_id = "<>"
    }
  }
}

# secret key vault data
data "vault_kv_secret_v2" "labiam07-kv" {
  mount = "secret"
  name = "test-secret"
}

# aws ec2 instance
resource "aws_instance" "labiam07-ec2" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  tags = {
    Name = "labiam07-ec2"
    Secret = data.vault_kv_secret_v2.labiam07-kv.data["devops"]
  }
}