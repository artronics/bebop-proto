data "archive_file" "proxy_bundle" {
  type        = "zip"
  source_dir = var.proxy.source_dir
  output_path = "./build/${var.proxy.name}.zip"
}

resource "apigee_proxy" "proxy" {
  name = var.proxy.name
  bundle = "./build/${var.proxy.name}.zip"
  bundle_hash = data.archive_file.proxy_bundle.output_sha
}

resource "apigee_proxy_deployment" "proxy_deployment" {
  proxy_name = apigee_proxy.proxy.name
  environment_name = var.apigee_environment
  revision = apigee_proxy.proxy.revision
}
