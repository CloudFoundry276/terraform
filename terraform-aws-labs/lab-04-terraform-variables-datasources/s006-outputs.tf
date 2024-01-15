# terraform output values
# ec2 instance public ip
output "instance_publicip" {
  description = "ec2 instance public ip"
  value = aws_instance.lab-04.public_ip
}

# ec2 instance public dns
output "instance_publicdns" {
  description = "ec2 instance public dns"
  value = aws_instance.lab-04.public_dns
}