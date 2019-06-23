locals {
  pool_cidr = "10.0.0.0/22"
}

resource "openstack_networking_subnetpool_v2" "subnet_pool" {
  name     = "subnet_pool"
  prefixes = ["${local.pool_cidr}"]
}

resource "openstack_networking_network_v2" "private" {
  region = "${var.region_name}"
  name   = "private"
}

resource "openstack_networking_subnet_v2" "private_subnet" {
  region          = "${var.region_name}"
  name            = "private-subnet"
  network_id      = "${openstack_networking_network_v2.private.id}"
  cidr            = "${cidrsubnet(local.pool_cidr, 4, 0)}"
  ip_version      = 4
  enable_dhcp     = true
  gateway_ip      = "${cidrhost(cidrsubnet(local.pool_cidr, 4, 0), 1)}"
  dns_nameservers = "${var.dns_nameservers}"
}
