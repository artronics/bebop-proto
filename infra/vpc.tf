resource "aws_vpc" "bebop-proto" {
  cidr_block = "10.1.0.0/16"
  tags       = {
    Name = "bebop-proto"
  }
}
