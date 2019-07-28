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

resource "openstack_networking_secgroup_rule_v2" "lite_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "${var.flat_cidr}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "${var.flat_cidr}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_bosh_agent" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6868
  port_range_max    = 6868
  remote_ip_prefix  = "${var.flat_cidr}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_bosh_director" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 25555
  port_range_max    = 25555
  remote_ip_prefix  = "${var.flat_cidr}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_https" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "${var.flat_cidr}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_uaa" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8443
  port_range_max    = 8443
  remote_ip_prefix  = "${var.flat_cidr}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_credhub" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 8844
  port_range_max    = 8844
  remote_ip_prefix  = "${var.flat_cidr}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "lite_secgrop" {
  region            = "${var.region_name}"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_group_id   = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
  security_group_id = "${openstack_networking_secgroup_v2.lite_seruciry_group.id}"
}

