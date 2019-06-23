resource "openstack_networking_secgroup_v2" "vms_seruciry_group" {
  name   = "vms_security_group"
  region = "${var.region_name}"
}

resource "openstack_networking_secgroup_rule_v2" "vms_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "vms_bosh_agent" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 6868
  port_range_max    = 6868
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "vms_bosh_director" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 25555
  port_range_max    = 25555
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "vms_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "vms_secgrop" {
  region            = "${var.region_name}"
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  remote_group_id   = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
  security_group_id = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
}
