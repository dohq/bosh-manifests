resource "openstack_networking_router_v2" "router" {
  region              = "${var.region_name}"
  name                = "router"
  admin_state_up      = true
  external_network_id = "${var.ext_net_id}"
}

resource "openstack_networking_router_interface_v2" "port" {
  region    = "${var.region_name}"
  router_id = "${openstack_networking_router_v2.router.id}"
  subnet_id = "${openstack_networking_subnet_v2.private_subnet.id}"
}

resource "openstack_networking_router_route_v2" "management" {
  depends_on = [
    "openstack_networking_router_interface_v2.port",
  ]
  router_id        = "${openstack_networking_router_v2.router.id}"
  destination_cidr = "${var.management_cidr}"
  next_hop         = "${var.management_gw}"
}
