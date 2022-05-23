variable "project" {
  default = "barz-proto"
}

variable "domain_name" {
  default = "dev.api.platform.nhs.uk"
}

variable "region" {
  default = "eu-west-2"
}

variable "environments" {
  default = ["dev"]
}

variable "service" {
  default = "barz_proto"
}

locals {
  environment = terraform.workspace
  name_prefix = "${var.project}-${var.environments[0]}"
}


variable "vpc_cidr" {
  default = "10.1.0.0/16"
}
