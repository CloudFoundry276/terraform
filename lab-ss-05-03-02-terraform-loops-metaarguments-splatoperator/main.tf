####################################################################################################
# Date: 12/24/2023
# Author: Sagar Pitalekar
# Title: Terraform Loops MetaArguments SplatOperator - MetaArgument For Each
# Description: In this lab, we demonstrate terraform instance type supported per az in a region 
#              datasource & output with for each.
####################################################################################################

# aws ec2 instance type offering datasource
data "aws_ec2_instance_type_offerings" "ds050302" {
  for_each = toset(["us-east-1a", "us-east-1b", "us-east-1e"])
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
output "out050302-1" {
  value = toset([for i in data.aws_ec2_instance_type_offerings.ds050302: i.instance_types])
}

output "out050302-2" {
  value = {for az, details in data.aws_ec2_instance_type_offerings.ds050302: az => details.instance_types}
}