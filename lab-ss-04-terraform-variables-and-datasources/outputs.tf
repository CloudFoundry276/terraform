# terraform outputs

# aws ec2 instance public ip
output "instance_publicip" {
  description = "aws ec2 instance public ip"
  value = aws_instance.tfvards.public_ip
}

# aws ec2 instance public dns
output "instance_publicdns" {
  description = "aws ec2 instance public dns"
  value = aws_instance.tfvards.public_dns
}