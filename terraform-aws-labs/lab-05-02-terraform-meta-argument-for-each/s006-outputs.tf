# terraform output values
# ec2 instance public ip with toset
output "instance_publicip" {
  description = "ec2 instance public ip with toset"
  value = toset([for instance in aws_instance.lab-05-02: instance.public_ip])
}

# ec2 instance public dns with toset
output "instance_publicdns" {
  description = "ec2 instance public dns with toset"
  value = toset([for instance in aws_instance.lab-05-02: instance.public_dns])
}

# ec2 instance public dns with tomap
output "instance_publicdns2" {
  description = "ec2 instance public dns with tomap"
  value = tomap({for az, instance in aws_instance.lab-05-02: az => instance.public_dns})
}