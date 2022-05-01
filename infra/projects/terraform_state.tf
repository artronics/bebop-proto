resource "aws_s3_bucket" "project_terraform_state" {
  bucket = "terraform-nhsd-apim-${var.project.name}"
}
