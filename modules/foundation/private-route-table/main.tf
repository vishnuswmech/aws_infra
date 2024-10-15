resource "aws_route_table" "nat_route" {
  vpc_id = var.vpc_id

  route {
    cidr_block = var.cidr
    gateway_id = "local"
  }
  route {
    cidr_block = var.open_to_all_cidr
    gateway_id = var.nat_gateway_id
  }
  tags = var.nat_rt_tags
  lifecycle {
    ignore_changes = [
      route
    ]
  }
}

resource "aws_route_table_association" "route_table_association" {
  count          = length(var.subnet_cidr)
  subnet_id      = var.subnet[count.index]
  route_table_id = aws_route_table.nat_route.id
}
