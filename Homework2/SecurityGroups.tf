# Create a security group assigned to ELB and WEB instances to allow #
# ingress ssh and http traffic, and egress all destinations #
resource "aws_security_group" "public-sg" {
  name = "public-sg"
  vpc_id = aws_vpc.whiskey-vpc.id
  tags = {
    Name = "public-sg"
  }
}
resource "aws_security_group_rule" "pub-ing-ssh" {
  type = "ingress"
  description = "pub-ing-ssh"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-sg.id
}
resource "aws_security_group_rule" "pub-ing-http" {
  type = "ingress"
  description = "pub-ing-http"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-sg.id
}
resource "aws_security_group_rule" "pub-egr-all" {
  type = "egress"
  description = "pub-egr-all"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public-sg.id
}
# Create a security group assigned to DB instances, to allow ingress #
# ssh traffic from VPC, and egress all destinations #
resource "aws_security_group" "private-sg" {
  name = "private-sg"
  vpc_id = aws_vpc.whiskey-vpc.id
  tags = {
    Name = "private-sg"
  }
}
resource "aws_security_group_rule" "pri-ing-ssh" {
  type = "ingress"
  description = "pri-ing-ssh"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["${var.vpc_cidr}"]
  security_group_id = aws_security_group.private-sg.id
}
resource "aws_security_group_rule" "pri-egr-all" {
  type = "egress"
  description = "pri-egr-all"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.private-sg.id
}