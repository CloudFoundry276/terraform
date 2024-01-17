# data source az
data "aws_availability_zones" "aws-az" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# data source ec2 instance type offerings
data "aws_ec2_instance_type_offerings" "instance-offer" {
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
output "out-1" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer: az => details.instance_types
  }
}

# output 2
output "out-2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer: az => details.instance_types if length(details.instance_types) != 0
  }
}

# output 3
output "out-3" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer: az => details.instance_types if length(details.instance_types) != 0
  })
}

# output 4
output "out-4" {
  value = keys({
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer: az => details.instance_types if length(details.instance_types) != 0
  })[0]
}