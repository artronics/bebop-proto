resource "aws_lb" "nlb" {
  name               = var.name_prefix
  internal           = true
  load_balancer_type = "application"

  subnets = var.public_subnet_ids
}
