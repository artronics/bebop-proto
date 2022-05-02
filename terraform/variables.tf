variable "project" {
  default = "barz"
}

variable "domain_name" {
  default = "artronics.me.uk"
}

variable "service" {
  default = "backend"
}

#variable "namespace" {
#  description = "User's short username for local deployment. It's equal to environment or pipeline and infra deployments"
#}

locals {
  environment = terraform.workspace
  valid_infra_envs = ["dev"]
  infra_env = contains(local.valid_infra_envs, local.environment) ? local.environment : "dev"
}


locals {
  service_domain_name = "${local.environment}.api.${var.domain_name}"
}

locals {
  name_prefix = "${var.project}-${var.service}-${local.environment}"
}
