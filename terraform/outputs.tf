output "instance_public_ip" {
  value = aws_instance.nifi.public_ip
}