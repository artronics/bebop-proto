variable "account_zone_id" {}
variable "vpc_id" {}

variable "environments" {
  type = set(string)
}

variable "region" {
  default = "eu-west-2"
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
