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

module "projects" {
  source = "./project"
  count  = length(local.projects)

  environment = var.environments[0]

  account_zone_id = data.aws_route53_zone.account_zone_id.zone_id
  vpc_id          = aws_vpc.bebop-proto.id

  project = local.projects[count.index]
}

output "projects_zone" {
  value = module.projects
}

