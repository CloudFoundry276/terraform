#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
sudo echo '<h1>Welcome to Terraform Variables & Datasources</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app
sudo echo '<!DOCTYPE html> <html> <body style="background-color: rgb(211, 211, 211);"> <h1>Welcome to Terraform Variables & Datasources</h1> <p>application version: 1.0.0</p> </body> </html>' | sudo tee /var/www/html/app/index.html