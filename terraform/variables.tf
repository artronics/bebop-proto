variable "project" {
  default = "barz"
}

variable "domain_name" {
  default = "dev.api.platform.nhs.uk"
}

variable "service" {
  default = "proxy"
}

locals {
  apigee_environment = "internal-dev"
}

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
