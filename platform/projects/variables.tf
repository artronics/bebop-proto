variable "account_zone_id" {}

variable "environments" {
  type = set(string)
}

/*
variable "environment" {
  type = string
  validation {
    condition = contains(["dev"],var.environment)
    error_message = "Invalid environment. Only \"dev\" is valid."
  }
}
*/

variable "project" {
  type = object({
    name = string
  })
}
