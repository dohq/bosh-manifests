resource "openstack_networking_floatingip_v2" "lite_concourse" {
  region = "${var.region_name}"
  pool   = "${var.ext_net_name}"
}

resource "openstack_networking_secgroup_v2" "lite_seruciry_group" {
  name                 = "lite_security_group"
  region               = "${var.region_name}"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "lite_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_ingress" {
  region            = "${var.region_name}"
  direction         = "ingress"
  ethertype         = "IPv4"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}
