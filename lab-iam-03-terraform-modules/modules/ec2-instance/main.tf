# configure aws provider
provider "aws" {
  region = "ap-south-1"
}

# configure aws ec2 instance
resource "aws_instance" "labiam03-ec2" {
  ami = var.ami_value
  instance_type = var.instance_type_value
  subnet_id = var.subnet_id_value
  tags = {
    Name = "labiam03-ec2"
  }
}