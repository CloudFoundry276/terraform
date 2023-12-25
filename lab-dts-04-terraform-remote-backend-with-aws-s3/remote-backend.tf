# remote backend
terraform {
  # s3 backend
  backend "s3" {
    bucket = "labdts04s3bucket"
    key = "global/s3/terraform.tfstate"
    region = "ap-south-1"

    dynamodb_table = "labdts04s3buckettbl"
    encrypt = true
  }
}

# configure aws ec2 instance
resource "aws_instance" "labdts04ec2" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = var.instance_type
  tags = {
    name = "labdts04ec2"
  }
}