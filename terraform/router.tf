resource "openstack_networking_router_v2" "router" {
  name           = "router"
  admin_state_up = true

  external_network_id = "${openstack_networking_network_v2.external.id}"
  enable_snat         = true
  external_fixed_ip {
    ip_address = "192.168.1.200"
    subnet_id  = "${openstack_networking_subnet_v2.external-subnet.id}"
  }
}

resource "openstack_networking_router_interface_v2" "external-port" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.internal-subnet.id}"
}

# resource "openstack_networking_router_interface_v2" "lb-mgmt-net-port" {
#   router_id = "${openstack_networking_router_v2.router.id}"
#   subnet_id = "${openstack_networking_subnet_v2.lb-mgmt-net-subnet.id}"
# }
