# resource block: ec2 instance
resource "aws_instance" "lab-03" {
  ami = "ami-0005e0cfe09cc9050"
  instance_type = "t2.micro"
  user_data = file("${path.module}/app-install.sh")
  tags = {
    "Name" = "lab-03"
  }
}