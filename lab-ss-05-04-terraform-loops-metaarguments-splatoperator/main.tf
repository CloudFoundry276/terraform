####################################################################################################
# Date: 12/24/2023
# Author: Sagar Pitalekar
# Title: Terraform Loops MetaArguments SplatOperator - MetaArgument For Each
# Description: In this lab, we demonstrate terraform to check for each meta-argument with   
#              availability zone instance type.
####################################################################################################

# configure aws ec2 instance
resource "aws_instance" "labss0504" {
  ami = data.aws_ami.amzlinux2023.id
  instance_type = var.instance_type
  user_data = file("${path.module}/install-apache-server.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-labss05-ssh.id, aws_security_group.vpc-labss05-web.id]
  for_each = toset(keys({for az, details in data.aws_ec2_instance_type_offerings.dsoutlabss0504: az => details.instance_types if length(details.instance_types) != 0}))
  availability_zone = each.key
  tags = {
    Name = "labss0504-${each.value}"
  }
}