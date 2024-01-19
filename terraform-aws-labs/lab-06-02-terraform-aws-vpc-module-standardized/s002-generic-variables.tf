# input variables
# aws region
variable "aws_region" {
  description = "region in which aws resources to be created"
  type = string
  default = "us-east-1"
}

# environment variable
variable "environment" {
  description = "environment variable used as a prefix"
  type = string
  default = "dev"
}

# business division
variable "business_division" {
  description = "business division in the large organization this infrastructure belongs"
  type = string
  default = "sap"
}