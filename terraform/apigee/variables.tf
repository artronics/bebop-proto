variable "apigee_environment" {}

variable "company" {}

variable "proxy" {
  type = object({
    name = string,
    source_dir = string,
  })
}

variable "app" {
  type = object({
    name = string
    display_name = string
    callback_url = string
    attributes = map(string)
  })
}


variable "product" {
  type = object({
    name = string
    display_name = string
    proxies = list(string)
    scopes = set(string)
    attributes = map(string)
  })
}

