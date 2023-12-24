# for loop with list output variable
output "for_loop_list" {
  description = "for loop with list"
  value = [for instance in awsaws_instance.labss0501: instance.public_dns]
}

# for loop with map output variable
output "for_loop_map" {
  description = "for loop with map"
  value = {for instance in aws_instance.labss0501: instance.id => instance.public_dns}
}

# for loop with advanced map output variable
output "for_loop_map_advanced" {
  description = "for loop with advanced map"
  value = {for i, instance in aws_instance.labss0501: i => instance.public_dns}
}

# return the list of latest generalized splat operator output variable
output "latest_splat_instance_publicdns" {
  description = "list of latest generalized splat operator"
  value = aws_instance.labss0501[*].public_dns
}