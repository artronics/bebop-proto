terraform {
  required_providers {
    apigee = {
      source  = "scastria/apigee"
      version = "~> 0.1.0"
    }
  }
}

resource "apigee_developer_app" "example" {
  developer_email = "jalal.hosseini1@nhs.net"
  name = "jalal-test"
  callback_url = "hello.com"
  attributes = {
    hello = "goodbye"
  }
}
