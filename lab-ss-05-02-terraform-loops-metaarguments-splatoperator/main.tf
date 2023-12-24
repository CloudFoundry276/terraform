####################################################################################################
# Date: 12/24/2023
# Author: Sagar Pitalekar
# Title: Terraform Loops MetaArguments SplatOperator - MetaArgument For Each
# Description: In this lab, we demonstrate terraform for each meta-argument with functions toset & 
#              tomap.
####################################################################################################

# configure aws ec2 instance
resource "aws_instance" "labss0502" {
  ami = data.aws_ami.amzlinux2023.id
  instance_type = var.instance_type
  user_data = file("${path.module}/install-apache-server.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-labss05-ssh.id, aws_security_group.vpc-labss05-web.id]
  # creates ec2 instance(s) in all az of vpc
  for_each = toset(data.aws_availability_zones.labss0502az.names)
  availability_zone = each.key
  tags = {
    Name = "for-each-az-demo-${each.value}"
  }
}