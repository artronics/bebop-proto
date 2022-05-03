resource "aws_s3_bucket" "test_bucket" {
  bucket = "jalal-test-${local.name_prefix}"
}
