resource "openstack_networking_secgroup_v2" "vms" {
  name                 = "vms"
  description          = "Default vms security group"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "vms-egress" {
  security_group_id = "${openstack_networking_secgroup_v2.vms.id}"

  direction        = "egress"
  ethertype        = "IPv4"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "vms-ingress" {
  security_group_id = "${openstack_networking_secgroup_v2.vms.id}"

  direction        = "ingress"
  ethertype        = "IPv4"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "vms-same-ingress" {
  security_group_id = "${openstack_networking_secgroup_v2.vms.id}"

  direction       = "ingress"
  ethertype       = "IPv4"
  remote_group_id = "${openstack_networking_secgroup_v2.vms.id}"
}

# octavia
resource "openstack_networking_secgroup_v2" "lb-mgmt-sec-grp" {
  name                 = "lb-mgmt-sec-grp"
  description          = "Default lb-mgmt-sec-grp security group"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "lb-mgmt-sec-grp-egress" {
  security_group_id = "${openstack_networking_secgroup_v2.lb-mgmt-sec-grp.id}"

  direction        = "egress"
  ethertype        = "IPv4"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "lb-mgmt-sec-grp-22" {
  security_group_id = "${openstack_networking_secgroup_v2.lb-mgmt-sec-grp.id}"

  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 22
  port_range_max   = 22
  remote_ip_prefix = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "lb-mgmt-sec-grp-9443" {
  security_group_id = "${openstack_networking_secgroup_v2.lb-mgmt-sec-grp.id}"

  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 9443
  port_range_max   = 9443
  remote_ip_prefix = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "lb-mgmt-sec-grp-5555" {
  security_group_id = "${openstack_networking_secgroup_v2.lb-mgmt-sec-grp.id}"

  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "udp"
  port_range_min   = 5555
  port_range_max   = 5555
  remote_ip_prefix = "0.0.0.0/0"
}
