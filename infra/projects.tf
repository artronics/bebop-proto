locals {
  projects = [
    {
      name = "barz"
    }
  ]
}

module "projects" {
  source = "./projects"
  count = length(local.projects)

  zone_id = data.aws_route53_zone.account_zone_id.zone_id
  environments = var.environments

  project = local.projects[count.index]

}

output "projects_zone" {
  value = [
  for p in module.projects : p.project_zone
  ]
}
