# data source
data "aws_ec2_instance_type_offerings" "instance-offer1" {
  filter {
    name = "instance-type"
    values = ["t2.micro"]
  }
  filter {
    name = "location"
    values = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  }
  location_type = "availability-zone"
}

# output
output "out-s002-v1-1" {
  value = data.aws_ec2_instance_type_offerings.instance-offer1.instance_types
}