resource "aws_s3_bucket" "certificate_bucket" {
  bucket = "${var.customer}-${var.envname}-${var.envtype}-cert-bucket"

  versioning {
    enabled = "true"
  }

  tags {
    Name            = "${local.tag_name}"
    EnvironmentName = "${local.tag_environmentname}"
    Profile         = "${local.tag_profile}"
  }
}
