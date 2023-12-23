# terraform output values
output "instance_publicip" {
  description = "ec2 instance public ip"
  value = aws_instance.labss02.public_ip
}

output "instance_publicdns" {
  description = "ec2 instance public dns"
  value = aws_instance.labss02.public_dns
}