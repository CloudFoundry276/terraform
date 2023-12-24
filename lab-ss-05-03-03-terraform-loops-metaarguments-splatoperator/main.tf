####################################################################################################
# Date: 12/24/2023
# Author: Sagar Pitalekar
# Title: Terraform Loops MetaArguments SplatOperator - Utility Project
# Description: In this lab, we demonstrate terraform datasource add new aws availability zone in a 
#              specific region.
####################################################################################################

# create new aws availability zone
data "aws_availability_zones" "az050303" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# aws ec2 instance type offering datasource
data "aws_ec2_instance_type_offerings" "ds050303" {
  for_each = toset(data.aws_availability_zones.az050303.names)
  filter {
    name = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}

# output variables
# returns all availability zones mapped to supported instance types
output "out050303-1" {
  value = {for az, details in data.aws_ec2_instance_type_offerings.ds050303: az => details.instance_types}
}

# exclude unsupported availability zones
output "out050303-2" {
  value = {for az, details in data.aws_ec2_instance_type_offerings.ds050303: az => details.instance_types if length(details.instance_types) != 0}
}

# returns list of availability zones supported for instance type
output "out050303-3" {
  value = keys({for az, details in data.aws_ec2_instance_type_offerings.ds050303: az => details.instance_types if length(details.instance_types) != 0})
}

# get 1st item from list
output "out050303-4" {
  value = keys({for az, details in data.aws_ec2_instance_type_offerings.ds050303: az => details.instance_types if length(details.instance_types) != 0})[0]
}