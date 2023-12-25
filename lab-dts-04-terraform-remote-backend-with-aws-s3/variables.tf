# variable aws region variable
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