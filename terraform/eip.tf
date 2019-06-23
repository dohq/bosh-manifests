resource "openstack_networking_floatingip_v2" "lite_concourse" {
  region = "${var.region_name}"
  pool   = "${var.ext_net_name}"
}
