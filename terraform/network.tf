resource "openstack_networking_network_v2" "external" {
  name           = "external"
  admin_state_up = true

  shared   = true
  external = true

  segments {
    network_type     = "${var.network-type}"
    physical_network = "${var.physical-network}"
  }
}

resource "openstack_networking_subnet_v2" "external-subnet" {
  name = "external-subnet"

  network_id = "${openstack_networking_network_v2.external.id}"
  ip_version = 4
  cidr       = "192.168.1.0/24"
  gateway_ip = "192.168.1.1"

  dns_nameservers = [
    "192.168.1.254",
    "1.1.1.1"
  ]

  allocation_pool {
    start = "192.168.1.25"
    end   = "192.168.1.99"
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
  cidr       = "10.0.0.0/24"
  gateway_ip = "10.0.0.1"

  dns_nameservers = [
    "192.168.1.254",
  ]
}
