module "project_infrastructure" {
  source       = "../infra/projects"
  project      = {
    name = var.project
  }
  environment = local.infra_env
}
