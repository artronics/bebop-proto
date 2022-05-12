resource "aws_vpc" "bebop-proto" {
  cidr_block = var.vpc_cidr
  tags       = {
    Name = var.project
  }
}
