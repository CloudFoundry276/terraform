# security group for ssh traffic
resource "aws_security_group" "sg-labss04-ssh" {
  name = "sg-labss04-ssh"
  description = "aws security group for ssh traffic"
  ingress {
    description = "allow port 22"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow all outbound ip addresses & ports"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-labss04-ssh"
  }
}

# security group for web traffic
resource "aws_security_group" "sg-labss04-web" {
  name = "sg-labss04-web"
  description = "aws security group for web traffic"
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
    description = "allow all outbound ip addresses & ports"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "sg-labss04-web"
  }
}