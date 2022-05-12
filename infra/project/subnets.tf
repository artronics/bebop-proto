locals {
  subnets = var.project.subnets
}

resource "aws_subnet" "subnets" {
  count                   = length(local.subnets)
  cidr_block              = local.subnets[count.index].cidr
  availability_zone       = local.subnets[count.index].availability_zone
  map_public_ip_on_launch = local.subnets[count.index].private ? "false" : "true"
  vpc_id                  = var.vpc_id

  tags = {
    Name = "${var.project.name}-${local.subnets[count.index].private ? "private" : "public"}-${local.subnets[count.index].availability_zone}"
  }
}
