resource "openstack_networking_router_v2" "router" {
  name           = "router"
  admin_state_up = true

  external_network_id = "${openstack_networking_network_v2.external.id}"
}

resource "openstack_networking_router_interface_v2" "port" {
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.internal-subnet.id}"
}
