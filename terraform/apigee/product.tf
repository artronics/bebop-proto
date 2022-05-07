resource "apigee_product" "product" {
  name = var.product.name
  display_name = var.product.display_name
  description = var.product.display_name
  environments = [
    var.apigee_environment
  ]

  auto_approval_type = true
  scopes = var.product.scopes
  attributes = var.product.attributes
  proxies = var.product.proxies
}
