#!/bin/bash
sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo service httpd start
sudo echo '<h1>Hello World from $(hostname -f)</h1>' | sudo tee /var/www/html/index.html
sudo mkdir /var/www/html/app
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(211, 211, 211);"> <h1>Hello World from $(hostname -f)</h1> </body></html>' | sudo tee /var/www/html/app/index.html
TOKEN=`curl -X PUT "http://169.254.169.254/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600"`
sudo curl -H "X-aws-ec2-metadata-token: $TOKEN" http://169.254.169.254/latest/dynamic/instance-identity/document -o /var/www/html/app/metadata.html