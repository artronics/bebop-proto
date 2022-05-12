variable "project" {}
variable "environment" {}

variable "vpc_id" {}
variable "internet_gateway_id" {}

locals {
  name_prefix = "${var.project}-${var.environment}"
}

variable "subnets" {
  type = list(object({
    cidr              = string
    availability_zone = string
  }))
}
