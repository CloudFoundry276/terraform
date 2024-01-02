# aws provider
provider "aws" {
  region = "ap-south-1"
}

# input variable for ami
variable "ami" {
  description = "ami value for ec2 instance"
}

# input variable for instance type
variable "instance_type" {
  description = "instance type value for ec2 instance"
}

# configure aws instance
resource "aws_instance" "labiam06-ec2" {
  ami = var.ami
  instance_type = var.instance_type
}