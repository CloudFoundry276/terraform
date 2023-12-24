# terraform output variables

# ec2 instance public ip with toset
output "instance_publicip" {
  description = "ec2 instance public ip"
  value = toset([for instance in aws_instance.labss0504: instance.public_ip])
}

# ec2 instance public dns with toset
output "instance_publicdns" {
  description = "ec2 instance public dns"
  value = toset([for instance in aws_instance.labss0504: instance.public_dns])
}

# ec2 instance public dns with tomap
output "instance_publicdns_map" {
  value = tomap({for az, instance in aws_instance.labss0504: az => instance.public_dns})
}

# returns all availability zones mapped to supported instance types
output "outlabss0504_1" {
  value = {for az, details in data.aws_ec2_instance_type_offerings.dsoutlabss0504: az => details.instance_types}
}

# exclude unsupported availability zones
output "outlabss0504_2" {
  value = {for az, details in data.aws_ec2_instance_type_offerings.dsoutlabss0504: az => details.instance_types if length(details.instance_types) != 0}
}

# returns list of availability zones supported for instance type with mapped keys function
output "outlabss0504_3" {
  value = keys({for az, details in data.aws_ec2_instance_type_offerings.dsoutlabss0504: az => details.instance_types if length(details.instance_types) != 0})
}