# Outputs the instances tags and public ips
output "aws_instance_tags_all" {
  value = aws_instance.Whiskey-WS[*].tags_all
}
output "aws_instance_public_ip" {
  value = aws_instance.Whiskey-WS[*].public_ip
}