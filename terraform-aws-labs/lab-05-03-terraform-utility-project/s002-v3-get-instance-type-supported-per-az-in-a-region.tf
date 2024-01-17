# data source az
data "aws_availability_zones" "aws-az" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# data source ec2 instance type offerings
data "aws_ec2_instance_type_offerings" "instance-offer3" {
  for_each = toset(data.aws_availability_zones.aws-az.names)
  filter {
    name = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name = "location"
    values = [each.key]
  }
  location_type = "availability-zone"
}

# output 1
output "out-s002-v3-1" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer3: az => details.instance_types
  }
}

# output 2
output "out-s002-v3-2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer3: az => details.instance_types if length(details.instance_types) != 0
  }
}

# output 3
output "out-s002-v3-3" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer3: az => details.instance_types if length(details.instance_types) != 0
  })
}

# output 4
output "out-s002-v3-4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer3: az => details.instance_types if length(details.instance_types) != 0
  })[0]
}