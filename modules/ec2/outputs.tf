output "public_ip" {
  value = aws_instance.public_ec2_instance[*].public_ip
}