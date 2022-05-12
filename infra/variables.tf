variable "project" {
  default = "bebop-proto"
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
  default = "infra-prot"
}

locals {
  environment = terraform.workspace
}

variable "vpc_cidr" {
  default = "10.1.0.0/16"
}
