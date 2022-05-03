locals {
  proxies_dir = "../proxies"
  proxies = [
    { name = "${var.name_prefix}-live", dir = "${local.proxies_dir}/live" },
    { name = "${var.name_prefix}-sandbox", dir = "${local.proxies_dir}/sandbox" }
  ]
}

data "archive_file" "proxies_bundle" {
  count = length(local.proxies)

  type        = "zip"
  source_dir = local.proxies[count.index].dir
  output_path = "./build/${local.proxies[count.index].name}.zip"
}

resource "apigee_proxy" "example" {
  count = length(local.proxies)

  name = local.proxies[count.index].name
  bundle = "./build/${local.proxies[count.index].name}.zip"
  bundle_hash = data.archive_file.proxies_bundle[count.index].output_sha
}
