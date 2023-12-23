# aws region variable
variable "aws_region" {
  description = "region in which aws resources to be created"
  type = string
  default = "ap-south-1"
}

# variable aws ec2 instance type
variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t2.micro"
}

# variable aws ec2 instance key pair
variable "instance_keypair" {
  description = "aws ec2 key pair that need to be associated with ec2 instance"
  type = string
  default = "TerraformKeyPair"
}