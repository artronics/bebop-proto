module "alb" {
  source            = "./alb"
  name_prefix       = local.name_prefix
  vpc_id            = aws_vpc.bebop-proto.id
  public_subnet_ids = module.subnets[*].subnet_id
}
