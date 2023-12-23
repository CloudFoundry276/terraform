####################################################################################################
# Date: 12/23/2023
# Author: Sagar Pitalekar
# Title: Terraform Settings - Providers & Resources
# Description: In this lab, we demonstrate terraform settings with provider(s) & resource(s).
####################################################################################################

# configure aws ec2 instance
resource "aws_instance" "tfspr" {
  ami = "ami-0a0f1259dd1c90938"
  instance_type = "t2.micro"
  user_data = file("${path.module}/install-apache-server.sh")
  tags = {
    Name = "TerraformSettingsProvidersAndResources"
  }
}