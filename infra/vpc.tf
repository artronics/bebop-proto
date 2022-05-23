resource "aws_vpc" "bebop-proto" {
  cidr_block = var.vpc_cidr

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = var.project
  }
}

locals {
  vpc_cidr = aws_vpc.bebop-proto.cidr_block
}
