####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Variable(s) & Datasource(s)
# Description: In this lab, we demonstrate terraform variable(s) & datasource(s) alongwith security 
#              group(s) & apache server installation using user data bash script file.
####################################################################################################

# configure aws ec2 instance
resource "aws_instance" "tfvards" {
  ami = data.aws_ami.amzlinux2.id
  instance_type = var.instance_type
  user_data = file("${path.module}/install-apache-server.sh")
  key_name = var.instance_keypair
  vpc_security_group_ids = [aws_security_group.vpc-labss04-ssh.id, aws_security_group.vpc-labss04-web.id]
  tags = {
    Name = "TerraformVariablesAndDatasources"
  }
}