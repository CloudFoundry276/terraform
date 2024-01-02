####################################################################################################
# Date: 01/02/2024
# Author: Sagar Pitalekar
# Title: Terraform Provisioners
# Description: In this lab, we demonstrate terraform provisioners.
####################################################################################################

# configure terraform version & required providers
terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# configure aws provider
provider "aws" {
  region = "ap-south-1"
}

# input variable
variable "cidr" {
  default = "10.0.0.0/16"
}

# aws key-pair
resource "aws_key_pair" "labiam05-keypair" {
  key_name = "labiam05-keypair"
  public_key = file("~/.ssh/id_rsa.pub")
}

# aws vpc
resource "aws_vpc" "labiam05-vpc" {
  cidr_block = var.cidr
}

# aws subnet
resource "aws_subnet" "labiam05-subnet" {
  vpc_id = aws_vpc.labiam05-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

# aws internet gateway
resource "aws_internet_gateway" "labiam05-ig" {
  vpc_id = aws_vpc.labiam05-vpc.id
}

# aws route table
resource "aws_route_table" "labiam05-rt" {
  vpc_id = aws_vpc.labiam05-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.labiam05-ig.id
  }
}

# aws route table association
resource "aws_route_table_association" "labiam05-rta" {
  subnet_id = aws_subnet.labiam05-subnet.id
  route_table_id = aws_route_table.labiam05-rt.id
}

# aws security group
resource "aws_security_group" "labiam05-sg" {
  name = "labiam05-sg"
  vpc_id = aws_vpc.labiam05-vpc.id
  ingress {
    description = "allow port 80"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow port 443"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all outbound ports"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "labiam05-sg"
  }
}

# aws ec2 instance with connection & provisioner
resource "aws_instance" "labiam05-ec2" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  key_name = aws_key_pair.labiam05-keypair.key_name
  vpc_security_group_ids = [aws_security_group.labiam05-sg.id]
  subnet_id = aws_subnet.labiam05-subnet.id

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("~/.ssh/id_rsa")
    host = self.public_ip
  }

  provisioner "file" {
    source = "app.py"
    destination = "/home/ec2-user/app.py"
  }

  provisioner "remote-exec" {
    inline = [
      "echo 'Hello, from Terraform Provisioner Remote Exec!'",
      "sudo dnf update -y",
      "sudo python3 --version",
      "sudo dnf search python3",
      "sudo dnf install python3-pip",
      "sudo dnf install python3.11 -y",
      "sudo python3.11 --version",
      "sudo dnf install python3.11-pip",
      "cd /home/ec2-user",
      "sudo pip3 install flask",
      "sudo python3 app.py &",
    ]
  }
}