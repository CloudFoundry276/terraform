####################################################################################################
# Date: 12/24/2023
# Author: Sagar Pitalekar
# Title: Terraform Loops MetaArguments SplatOperator - MetaArgument For Each
# Description: In this lab, we demonstrate terraform instance type supported per az in a region  
#              with datasource & output.
####################################################################################################

# aws ec2 instance type offering datasource
data "aws_ec2_instance_type_offerings" "ds050301" {
  filter {
    name = "instance-type"
    values = ["t3.micro"]
  }
  filter {
    name = "location"
    values = ["us-east-1e"]
  }
  location_type = "availability-zone"
}

# output varuable
output "out050301" {
  value = data.aws_ec2_instance_type_offerings.ds050301.instance_types
}