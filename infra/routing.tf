resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.bebop-proto.id

  tags = {
    Name = var.project
  }
}
