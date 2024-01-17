# terraform output values
# output legacy splat operator (returns the list)
output "legacy_splat_instance_publicdns" {
  description = "legacy splat operator"
  value = aws_instance.lab-05-01.*.public_dns
}

# output latest generalized splat operator (returns the list)
output "latest_splat_instance_publicdns" {
  description = "generalized latest splat operator"
  value = aws_instance.lab-05-01[*].public_dns
}