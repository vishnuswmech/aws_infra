output "tags" {

  value = aws_vpc.vpc.tags
}

output "cidr" {
  value = aws_vpc.vpc.cidr_block
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}

