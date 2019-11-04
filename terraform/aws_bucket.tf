resource "random_integer" "aws-suffix" {
  min = 0
  max = 10000
}

resource "aws_s3_bucket" "bosh-creds" {
  bucket = "dohq-bosh-creds-${random_integer.aws-suffix.result}"

  versioning {
    enabled = true
  }
}
