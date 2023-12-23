# terraform output values
output "ec2_instance_publicip" {
  description = "ec2 instance public ip"
  value = aws_instance.tftlls.public_ip
}