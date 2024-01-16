# terraform output values
# output for loop with list
# output "for_output_list" {
#   description = "for loop with list"
#   value = [for instance in aws_aws_instance.lab-05-01: instance.public_dns]
# }

# output for loop with map
# output "for_output_map1" {
#   description = "for loop with map"
#   value = {for instance in aws_aws_instance.lab-05-01: instance.id => instance.public_dns}
# }

# output for loop with map advanced
# output "for_output_map2" {
#   description = "for loop with map advanced"
#   value = {for s, instance in aws_aws_instance.lab-05-01: s => instance.public_dns}
# }

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