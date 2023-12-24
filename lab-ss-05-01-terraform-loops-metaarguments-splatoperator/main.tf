####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Loops MetaArguments SplatOperator - MetaArgument Count For Loops Lists Maps
# Description: In this lab, we demonstrate terraform for loops, lists, maps & count meta-argument.
####################################################################################################

# configure aws ec2 instance
resource "aws_instance" "labss0501" {
  ami = data.aws_ami.amzlinux2023.id
  # instance_type = var.instance_type
  instance_type = var.instance_type_list[1]
  user_data = file("${path.module}/install-apache-server.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-labss05-ssh.id, aws_security_group.vpc-labss05-web.id]
  count = 3
  tags = {
    Name = "count-ldemo-${count.index}"
  }
}