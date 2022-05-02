locals {
  projects = [
  ]
}

module "projects" {
  source = "./projects"
  count = length(local.projects)

  account_zone_name = data.aws_route53_zone.account_zone_id.zone_id
  environment = var.environments

  project = local.projects[count.index]

}

output "projects_zone" {
  value = module.projects

}
