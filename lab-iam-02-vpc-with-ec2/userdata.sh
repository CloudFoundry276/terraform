#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
sudo systemctl enable httpd
sudo service httpd start
sudo echo '<h1>Welcome to Terraform Demo</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app
sudo echo '<!DOCTYPE html> <html> <head> <title>Welcome Page 1</title> <style> @keyframes colorChange { 0% { color: red; } 50% { color: green; } 100% { color: blue; } } h1 { animation: colorChange 2s infinite; } </style> </head> <body> <h1>Hello, World from Terraform 1!</h1> <h2>Instance ID: <span style="color:green">'$INSTANCE_ID'</span></h2> <p>Welcome to Terraform Demo 1</p> </body>
</html>' | sudo tee /var/www/html/app/index.html