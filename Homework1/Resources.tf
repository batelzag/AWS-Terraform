# Deploy intances in default vpc
resource "aws_default_vpc" "default" {
}
# Create a security group assigned to vpc, to allow ssh and http traffic 
resource "aws_security_group" "Whiskey-sg" {
  name = "Whiskey-sg"
  vpc_id = aws_default_vpc.default.id
}
resource "aws_security_group_rule" "in-ssh" {
  type = "ingress"
  description = "in-ssh"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Whiskey-sg.id
}
resource "aws_security_group_rule" "in-http" {
  type = "ingress"
  description = "in-http"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Whiskey-sg.id
}
resource "aws_security_group_rule" "eg-all" {
  type = "egress"
  description = "eg-all"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.Whiskey-sg.id
}
# Launch a number of instances with the specified settings
resource "aws_instance" "Whiskey-WS" {
  count         = var.instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone        = var.availability_zone
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.Whiskey-sg.id]
  root_block_device {
    volume_size = 10
    volume_type = "gp2"
  }
  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = 10
    encrypted = true
    volume_type = "gp2"
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              echo "<html><body><h1>Welcome to Grandpa's Whiskey</h1></body></html>" > /var/www/html/index.html
              EOF
  tags = {
    Name = "Whiskey-WS${count.index + 1}"
    Owner = "Whiskey"
    purpose = "Grandpa's Whiskey Web Server"
  }
}