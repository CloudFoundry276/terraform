# get latest ami id for amazon linux 2023
data "aws_ami" "amzlinux2023" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["al2023-ami-*"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

# get list of availability zones in a specific region
data "aws_availability_zones" "azlabss0504" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# get list of all availability zones in a particular region where respective instance type is supported
data "aws_ec2_instance_type_offerings" "dsoutlabss0504" {
  for_each = toset(data.aws_availability_zones.azlabss0504.names)
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