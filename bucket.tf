resource "aws_s3_bucket" "certificate_bucket" {
  bucket = "${var.name}-${var.envname}-cert-bucket"

  versioning {
    enabled = "true"
  }
}
