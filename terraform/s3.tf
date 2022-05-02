resource "aws_s3_bucket" "test_bucket" {
  bucket = "artronics-${local.name_prefix}"
}
