# terraform output values

# ec2 instance public ip with toset
output "instance_publicip" {
  description = "ec2 instance public ip"
  # legacy splat
  # value = aws_instance.labss0502.*.public_ip
  # latest splat
  # value = aws_instance.labss0502[*].public-ip
  value = toset([for instance in aws_instance.labss0502: instance.public_ip])
}

# ec2 instance public dns with toset
output "instance_publicdns" {
  description = "ec2 instance public dns"
  # legacy splat
  # value = aws_instance.labss0502.*.public_dns
  # latest splat
  # value = aws_instance.labss0502[*].public_dns
  value = toset([for instance in aws_instance.labss0502: instance.public_dns])
}

# ec2 instance public dns with tomap
output "instance_publicdns_map" {
  value = tomap({for az, instance in aws_instance.labss0502: az => instance.public_dns})
}