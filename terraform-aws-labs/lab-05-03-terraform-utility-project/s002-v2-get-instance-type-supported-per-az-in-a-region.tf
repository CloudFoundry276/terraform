# data source
data "aws_ec2_instance_type_offerings" "instance-offer2" {
  for_each = toset(["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"])
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
output "out-s002-v2-1" {
  value = toset([for t in data.aws_ec2_instance_type_offerings.instance-offer2: t.instance_types])
}

# output 2
output "out-s002-v2-2" {
  value = {
    for az, details in data.aws_ec2_instance_type_offerings.instance-offer2: az => details.instance_types
  }
}