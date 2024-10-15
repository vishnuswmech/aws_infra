resource "aws_eip" "lb" {
  domain = "vpc"
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.lb.id
  subnet_id     = var.public_subnet_id
}