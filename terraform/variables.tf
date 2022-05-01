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
}

locals {
  service_domain_name = "${local.environment}.api.${var.domain_name}"
}
locals {
  name_prefix = "${var.project}-${var.service}-${local.environment}"
}
