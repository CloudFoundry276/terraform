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

data "aws_availability_zones" "labss0502az" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}