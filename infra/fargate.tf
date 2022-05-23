locals {
  projects = [
    {
      name    = "barz_proto",
      subnets = [
        {
          cidr              = "10.1.1.0/24"
          private           = false
          availability_zone = "eu-west-2a"
        }
      ]
    }
  ]
}


module "fargate" {
  source      = "./fargate"
  region      = var.region
  name_prefix = local.name_prefix

  vpc_id  = aws_vpc.bebop-proto.id
  subnets = [
    {
      cidr              = cidrsubnet(local.vpc_cidr, 8, 101)
      availability_zone = "eu-west-2a"
    }, {
      cidr              = cidrsubnet(local.vpc_cidr, 8, 102)
      availability_zone = "eu-west-2b"
    }, {
      cidr              = cidrsubnet(local.vpc_cidr, 8, 103)
      availability_zone = "eu-west-2c"
    }
  ]
}

