####################################################################################################
# Date: 12/27/2023
# Author: Sagar Pitalekar
# Title: Terraform VPC with EC2
# Description: In this lab, we demonstrate vpc with ec2 instance using terraform.
####################################################################################################

# configure aws vpc
resource "aws_vpc" "labiam02-vpc" {
  cidr_block = var.cidr
}

# configure aws subnet 1
resource "aws_subnet" "labiam02-subnet1" {
  vpc_id = aws_vpc.labiam02-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

# configure aws subnet 2
resource "aws_subnet" "labiam02-subnet2" {
  vpc_id = aws_vpc.labiam02-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
}

# configure aws internet gateway
resource "aws_internet_gateway" "labiam02-ig" {
  vpc_id = aws_vpc.labiam02-vpc.id
}

# configure aws route table
resource "aws_route_table" "labiam02-rt" {
  vpc_id = aws_vpc.labiam02-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.labiam02-ig.id
  }
}

# configure aws route table association 1
resource "aws_route_table_association" "labiam02-rta1" {
  subnet_id = aws_subnet.labiam02-subnet1.id
  route_table_id = aws_route_table.labiam02-rt.id
}

# configure aws route table association 2
resource "aws_route_table_association" "labiam02-rta2" {
  subnet_id = aws_subnet.labiam02-subnet2.id
  route_table_id = aws_route_table.labiam02-rt.id
}

# configure aws security group
resource "aws_security_group" "labiam02-sg" {
  name = "labiam02-sg"
  vpc_id = aws_vpc.labiam02-vpc.id
  ingress {
    description = "allow port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
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
  egress {
    description = "allow outbound traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# configure aws s3 bucket
resource "aws_s3_bucket" "labiam02-s3bucket" {
  bucket = "labiam02-s3bucket"
}

# configure aws ec2 instance 1
resource "aws_instance" "labiam02-ec2-01" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.labiam02-sg.id]
  subnet_id = aws_subnet.labiam02-subnet1.id
  user_data = base64encode(file("${path.module}/userdata.sh"))
}

# configure aws ec2 instance 2
resource "aws_instance" "labiam02-ec2-02" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.labiam02-sg.id]
  subnet_id = aws_subnet.labiam02-subnet2.id
  user_data = base64encode(file("${path.module}/userdata1.sh"))
}

# configure aws application load balancer - alb
resource "aws_lb" "labiam02-alb" {
  name = "labiam02-alb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.labiam02-sg.id]
  subnets = [aws_subnet.labiam02-subnet1.id, aws_subnet.labiam02-subnet2.id]
  tags = {
    Name = "labiam02-alb"
  }
}

# configure aws application load balancer - alb target group
resource "aws_lb_target_group" "labiam02-alb-tg" {
  name = "labiam02-alb-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.labiam02-vpc.id
  health_check {
    path = "/"
    port = "traffic-port"
  }
}

# configure aws application load balancer - alb target group attachment 1
resource "aws_lb_target_group_attachment" "labiam02-alb-tga1" {
  target_group_arn = aws_lb_target_group.labiam02-alb-tg.arn
  target_id = aws_instance.labiam02-ec2-01.id
  port = 80
}

# configure aws application load balancer - alb target group attachment 2
resource "aws_lb_target_group_attachment" "labiam02-alb-tga2" {
  target_group_arn = aws_lb_target_group.labiam02-alb-tg.arn
  target_id = aws_instance.labiam02-ec2-02.id
  port = 80
}

# configure aws application load balancer - alb listener
resource "aws_lb_listener" "labiam02-albl" {
  load_balancer_arn = aws_lb.labiam02-alb.arn
  port = 80
  protocol = "HTTP"
  default_action {
    target_group_arn = aws_lb_target_group.labiam02-alb-tg.arn
    type = "forward"
  }
}

# configure output variable - load balancer dns
output "labiam02-alb-dns" {
  description = "returns application load balancer dns"
  value = aws_lb.labiam02-alb.dns_name
}