resource "aws_route_table" "igw_route" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr
    gateway_id = "local"
  }
  route {
    cidr_block = var.open_to_all_cidr
    gateway_id = var.internet_gateway_id
  }
  tags = var.igw_rt_tags
}

resource "aws_route_table_association" "route_table_association" {
  subnet_id      = var.subnet
  route_table_id = aws_route_table.igw_route.id
}
