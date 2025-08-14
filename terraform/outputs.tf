output "instance_public_ip" {
  value = aws_instance.t2_medium_ec2.public_ip
}