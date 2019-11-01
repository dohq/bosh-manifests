provider "openstack" {

}

terraform {
  required_version = ">=0.11.0"
  backend "s3" {
    bucket = "dohq-openstack-tfstate"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"
  }
}
