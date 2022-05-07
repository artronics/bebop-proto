resource "apigee_company" "company" {
  name = var.company
  display_name = "${var.app.display_name} Company"
}

resource "apigee_company_app" "app" {
  company_name = apigee_company.company.name
  name =  var.app.name
  callback_url = var.app.callback_url
  attributes = var.app.attributes
}
