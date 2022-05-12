resource "aws_subnet" "private_subnets" {
  count             = length(var.subnets)
  cidr_block        = var.subnets[count.index].cidr
  availability_zone = var.subnets[count.index].availability_zone
  vpc_id            = var.vpc_id

  tags = {
    Name = "${local.name_prefix}-private-${var.subnets[count.index].availability_zone}"
  }
}

resource "aws_subnet" "public_subnet" {
  cidr_block              = "10.1.102.0/24"
  availability_zone       = "eu-west-2b"
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = true

  tags = {
    Name = "${local.name_prefix}-public-eu-west-2b"
  }
}

