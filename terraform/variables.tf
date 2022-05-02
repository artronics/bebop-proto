variable "project" {
  default = "barz"
}

variable "domain_name" {
  default = "artronics.me.uk"
}

variable "service" {
  default = "backend"
}

locals {
  environment = terraform.workspace
  valid_envs = ["dev"]
  infra_env = contains(local.valid_envs, local.environment) ? local.environment : "user"
}


locals {
  service_domain_name = "${local.environment}.api.${var.domain_name}"
}

locals {
  name_prefix = "${var.project}-${var.service}-${local.environment}"
}
