# Launch WEB server instances #
resource "aws_instance" "Whiskey-WS" {
  count         = var.instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone        = var.availability_zone[count.index]
  subnet_id = element(aws_subnet.whiskey-public.*.id,count.index)
  associate_public_ip_address = true
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  key_name = var.key_name
  user_data = local.instance-userdata
  tags = {
    Name = "Whiskey-WS${count.index + 1}"
    Owner = "Whiskey"
    purpose = "Grandpa's Whiskey Web Server"
  }
}
# Launch DB server instances #
resource "aws_instance" "Whiskey-DB" {
  count         = var.instance_count
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  availability_zone        = var.availability_zone[count.index]
  subnet_id = element(aws_subnet.whiskey-private.*.id,count.index)
  associate_public_ip_address = false
  vpc_security_group_ids = [aws_security_group.private-sg.id]
  key_name = var.key_name
  tags = {
    Name = "Whiskey-DB${count.index + 1}"
    Owner = "Whiskey"
    purpose = "Grandpa's Whiskey Data Base"
  }
}