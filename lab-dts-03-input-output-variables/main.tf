####################################################################################################
# Date: 12/25/2023
# Author: Sagar Pitalekar
# Title: Terraform Deploy Apache Webserver on AWS Cloud
# Description: In this lab, we demonstrate how to deploy apache webserver on aws ec2 instance 
#              (ubuntu & amazon linux 2023 ec2 instance) i.e. aws cloud with input & output 
#              variable(s) & implicit dependencies.
####################################################################################################

# configure aws ec2 instance
resource "aws_instance" "labdts03-amznlinux" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.labdts03-ssh.id, aws_security_group.labdts03-web.id, aws_security_group.labdts03-custom.id]
  user_data = <<-EOF
  #!/bin/bash
  sudo yum update -y
  sudo yum install -y httpd
  sudo systemctl enable httpd
  sudo service httpd start
  sudo echo '<h1>Welcome to Terraform Apache Demo</h1>' | sudo tee /var/www/html/index.html
  sudo mkdir /var/www/html/app
  sudo echo '<!DOCTYPE html> <html> <body style="background-color: rgb(211, 211, 211);"> <h1>Welcome to Terraform Apache Demo</h1> <p>application version: 1.0.0</p> </body> </html>' | sudo tee /var/www/html/app/index.html
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "labdts03-amznlinux"
  }
}

resource "aws_instance" "labdts03-ubuntu" {
  ami = "ami-03f4878755434977f"
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.labdts03-ssh.id, aws_security_group.labdts03-web.id, aws_security_group.labdts03-custom.id]
  user_data = <<-EOF
  #!/bin/bash
  echo "Hello, World!" > index.html
  nohup busybox httpd -f -p 8080 &
  EOF
  user_data_replace_on_change = true
  tags = {
    Name = "labdts03-ubuntu"
  }
}