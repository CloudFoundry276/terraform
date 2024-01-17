# ec2 instance
resource "aws_instance" "lab-05-04" {
  ami = data.aws_ami.al2023.id
  instance_type = var.instance_type
  user_data = file("${path.module}/app-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  for_each = toset(keys({for az, details in data.aws_ec2_instance_type_offerings.instance-offer: az => details.instance_types if length(details.instance_types) != 0}))
  availability_zone = each.key
  tags = {
    Name = "lab-05-04-${each.key}"
  }
}