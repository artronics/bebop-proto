module "alb" {
  source            = "./alb"
  name_prefix       = local.name_prefix
  public_subnet_ids = aws_subnet.public_subnets[*].id
}
