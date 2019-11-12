resource "openstack_networking_network_v2" "external" {
  name           = "external"
  admin_state_up = true

  shared   = true
  external = true

  segments {
    network_type     = "${var.network_type}"
    physical_network = "${var.physical_network}"
  }
}

resource "openstack_networking_subnet_v2" "external-subnet" {
  name = "external-subnet"

  network_id = "${openstack_networking_network_v2.external.id}"
  ip_version = 4
  cidr       = "${var.external_subnet_cidr}"
  gateway_ip = "${var.external_subnet_gateway}"

  dns_nameservers = [
    "${var.external_subnet_dns}",
    "1.1.1.1"
  ]

  allocation_pool {
    start = "${var.external_subnet_allocation_start}"
    end   = "${var.external_subnet_allocation_end}"
  }
}

resource "openstack_networking_network_v2" "internal" {
  name = "internal"

  shared         = true
  admin_state_up = true

  segments {
    network_type = "vxlan"
  }
}

resource "openstack_networking_subnet_v2" "internal-subnet" {
  name = "internal-subnet"

  network_id = "${openstack_networking_network_v2.internal.id}"
  ip_version = 4
  cidr       = "${var.internal_subnet_cidr}"
  gateway_ip = "${var.internal_subnet_gateway}"

  dns_nameservers = [
    "${var.external_subnet_dns}",
  ]
}

resource "openstack_networking_network_v2" "lb-mgmt-net" {
  name = "lb-mgmt-net"

  shared         = true
  external       = true
  admin_state_up = true

  segments {
    network_type = "vxlan"
  }
}

resource "openstack_networking_subnet_v2" "lb-mgmt-net-subnet" {
  name = "lb-mgmt-net-subnet"

  network_id = "${openstack_networking_network_v2.lb-mgmt-net.id}"
  ip_version = 4
  cidr       = "${var.lb_mgmt_subnet_cidr}"
  gateway_ip = "${var.lb_mgmt_subnet_gateway}"

  allocation_pool {
    start = "${var.lb_mgmt_subnet_allocation_start}"
    end   = "${var.lb_mgmt_subnet_allocation_end}"
  }
}
