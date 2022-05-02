locals {
  valid_envs = ["dev"]
  infra_env = contains(local.valid_envs, local.environment) ? local.environment : "user"
}

module "project_infrastructure" {
  source       = "../infra/projects"
  project      = {
    name = var.project
  }
  environment = local.infra_env
}
