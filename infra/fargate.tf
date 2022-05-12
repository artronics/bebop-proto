module "fargate" {
  source      = "./fargate"
  project     = "hosted_container"
  environment = var.environments[0]

  vpc_id              = aws_vpc.bebop-proto.id
  internet_gateway_id = aws_internet_gateway.internet_gateway.id

  subnets = [
    {
      cidr              = cidrsubnet(var.vpc_cidr, 8, 100)
      availability_zone = "eu-west-2a"
    },
    {
      cidr              = cidrsubnet(var.vpc_cidr, 8, 101)
      availability_zone = "eu-west-2b"
    }
  ]
}
