# ec2 instance
resource "aws_instance" "lab-05-01" {
  ami = data.aws_ami.al2023.id
  instance_type = var.instance_type
  # instance_type = var.instance_type_list[1]
  # instance_type = var.instance_type_map["prod"]
  user_data = file("${path.module}/app-install.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-ssh.id, aws_security_group.vpc-web.id]
  count = 2
  tags = {
    Name = "lab-05-01-vm-${count.index}"
  }
}