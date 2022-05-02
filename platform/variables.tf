variable "project" {
  default = "bebop"
}

variable "domain_name" {
  default = "artronics.me.uk"
}

variable "environments" {
  default = ["dev"]
}

variable "service" {
  default = "infra"
}

locals {
  environment = terraform.workspace
}

locals {
  service_domain_name = "${local.environment}.api.${var.domain_name}"
}
locals {
  name_prefix = "${var.project}-${var.service}-${local.environment}"
}
