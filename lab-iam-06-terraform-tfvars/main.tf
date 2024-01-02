# configure aws provider
provider "aws" {
  region = "ap-south-1"
}

# input variable for ami ec2 instance
variable "ami" {
  description = "ami value for ec2 instance"
}

# input variable for instance type ec2 instance
variable "instance_type" {
  description = "instance type value for ec2 instance"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "stage" = "t2.medium"
    "prod" = "t2.xlarge"
  }
}

module "ec2-instance" {
  source = "./modules/ec2-instance"
  ami = var.ami
  instance_type = lookup(var.instance_type, terraform.workspace, "t2.micro")
}