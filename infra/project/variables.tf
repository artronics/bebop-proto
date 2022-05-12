variable "account_zone_id" {}
variable "vpc_id" {}

variable "region" {
  default = "eu-west-2"
}

variable "environment" {
}

locals {
  name_prefix = "${var.project.name}-${var.environment}"
}

variable "project" {
  type = object({
    name    = string
    subnets = list(object({
      cidr              = string
      private           = bool
      availability_zone = string
    }))
  })
}
