# output variables

# output public ip of created resource
output "output_publicip_amznlinux" {
  description = "returns public ip of web server amzn linux"
  value = aws_instance.labdts03-amznlinux.public_ip
}

output "output_publicip_ubuntu" {
  description = "returns public ip of web server ubuntu"
  value = aws_instance.labdts03-ubuntu.public_ip
}