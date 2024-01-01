# configure backend for statefile
terraform {
  backend "s3" {
    bucket = "labiam04-s3bucket"
    key = "labiam04/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
    dynamodb_table = "labiam04-dynamodb"
  }
}