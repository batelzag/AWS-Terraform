locals {
  instance-userdata = <<USERDATA
#!/bin/bash

sudo apt update -y
sudo apt install nginx -y
echo "<html><body><h1>Welcome to Grandpa's Whiskey</h1></body></html>" | sudo tee /var/www/html/index.html
service nginx restart

USERDATA
}