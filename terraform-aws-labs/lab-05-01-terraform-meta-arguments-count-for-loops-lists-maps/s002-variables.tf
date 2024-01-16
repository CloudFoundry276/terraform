# input variables
# aws region
variable "aws_region" {
  description = "region in which aws resources to be created"
  type = string
  default = "us-east-1"
}

# aws ec2 instance type
variable "instance_type" {
  description = "ec2 instance type"
  type = string
  default = "t2.micro"
}

# aws ec2 instance key pair
variable "instance_keypair" {
  description = "aws ec2 key pair that need to be associated with ec2 instance"
  type = string
  default = "terraform-key"
}

# aws ec2 instance type list
variable "instance_type_list" {
  description = "ec2 instance type list"
  type = list(string)
  default = ["t2.micro", "t2.small", "t2.large"]
}

# aws ec2 instance type map
variable "instance_type_map" {
  description = "ec2 instance type map"
  type = map(string)
  default = {
    "dev" = "t2.micro"
    "qa" = "t2.small"
    "prod" = "t2.large"
  }
}