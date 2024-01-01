# output variables
output "labiam03-publicip" {
  value = aws_instance.labiam03-ec2.public_ip
}