resource "openstack_networking_floatingip_v2" "jumpbox" {
  pool = "${openstack_networking_network_v2.external.name}"
}
