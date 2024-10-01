output "public_ip" {
  value = aws_instance.public_ec2_instance[0].public_ip
}