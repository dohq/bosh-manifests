provider "openstack" {}

provider "environment" {}

data "environment_variable" "HOME" {
  name                = "HOME"
  fail_if_empty       = true
  normalize_file_path = true
}

terraform {
  required_version = ">=0.11.0"
  backend "s3" {
    bucket = "dohq-openstack-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
