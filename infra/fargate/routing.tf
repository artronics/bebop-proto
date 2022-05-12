resource "aws_route_table" "fargate_route_table" {
  vpc_id = var.vpc_id
}

resource "aws_eip" "nat_gateway_ip" {

}

resource "aws_nat_gateway" "nat_gateway" {
  connectivity_type = "public"
  allocation_id     = aws_eip.nat_gateway_ip.id
  subnet_id         = aws_subnet.public_subnet.id
}


resource "aws_route" "nat_gateway" {
  route_table_id         = aws_route_table.fargate_route_table.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat_gateway.id
  depends_on             = [aws_route_table.fargate_route_table]
}

resource "aws_route_table_association" "private_subnets_routing" {
  count = length(var.subnets)

  route_table_id = aws_route_table.fargate_route_table.id
  subnet_id      = aws_subnet.private_subnets[count.index].id
}


resource "aws_route_table" "public_subnet_route_table" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "${local.name_prefix}-public"
  }
}

resource "aws_route_table_association" "my_vpc_us_east_1a_public" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_subnet_route_table.id
}
