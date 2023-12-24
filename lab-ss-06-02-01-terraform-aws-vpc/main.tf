####################################################################################################
# Date: 12/24/2023
# Author: Sagar Pitalekar
# Title: AWS VPC using Terraform
# Description: In this lab, we demonstrate aws vpc using terraform simple & basic architecture.
####################################################################################################

# create vpc terraform module
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.4.0"

  # vpc basic details
  name = "vpc-dev"
  cidr = "10.0.0.0/16"
  azs = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  # database subnets
  create_database_subnet_group = true
  create_database_subnet_route_table = true
  database_subnets = ["10.0.151.0/24", "10.0.152.0/24"]

  # nat gateways for outbound communications
  enable_nat_gateway = true
  single_nat_gateway = true

  # vpc dns parameters
  enable_dns_hostnames = true
  enable_dns_support = true

  public_subnet_tags = {
    type = "public-subnets"
  }

  private_subnet_tags = {
    type = "private-subnets"
  }

  database_subnet_tags = {
    type = "database-subnets"
  }

  tags = {
    owner = "sagar"
    environment = "dev"
  }

  vpc_tags = {
    name = "vpc-dev"
  }
}