output "public_ip" {
  value = aws_instance.instance_names.public_ip
}