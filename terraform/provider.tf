provider "openstack" {
  auth_url    = "${var.auth_url}"
  user_name   = "${var.user_name}"
  password    = "${var.password}"
  tenant_name = "${var.tenant_name}"
  domain_name = "${var.domain_name}"
  version = "~> 1.16"
}
