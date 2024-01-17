# data source for availability zones
data "aws_availability_zones" "lab-05-02-az" {
  filter {
    name = "opt-in-status"
    values = ["opt-in-not-required"]
  }
}

# ec2 instance
resource "aws_instance" "lab-05-02" {
  ami = data.aws_ami.al2023.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  for_each = toset(data.aws_availability_zones.lab-05-02-az.names)
  availability_zone = each.key
  tags = {
    Name = "lab-05-02-${each.value}"
  }
}