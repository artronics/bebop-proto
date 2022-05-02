variable "account_zone_name" {
  default = "artronics.me.uk"
}

variable "environment" {
  type = string
  validation {
    condition = contains(["dev", "user"],var.environment)
    error_message = "Invalid environment. Only \"dev\" and \"user\" are valid."
  }
}

variable "project" {
  type = object({
    name = string
  })
}
