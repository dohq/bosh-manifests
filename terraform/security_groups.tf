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
  remote_ip_prefix = "192.168.1.0/24"
}

resource "openstack_networking_secgroup_rule_v2" "vms-same-ingress" {
  security_group_id = "${openstack_networking_secgroup_v2.vms.id}"

  direction       = "ingress"
  ethertype       = "IPv4"
  remote_group_id = "${openstack_networking_secgroup_v2.vms.id}"
}

resource "openstack_networking_secgroup_rule_v2" "vms-jumpbox-ingress" {
  security_group_id = "${openstack_networking_secgroup_v2.vms.id}"

  direction       = "ingress"
  ethertype       = "IPv4"
  remote_group_id = "${openstack_networking_secgroup_v2.jumpbox.id}"
}

resource "openstack_networking_secgroup_v2" "jumpbox" {
  name                 = "jumpbox"
  description          = "Default jumpbox security group"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox-egress" {
  security_group_id = "${openstack_networking_secgroup_v2.jumpbox.id}"

  direction        = "egress"
  ethertype        = "IPv4"
  remote_ip_prefix = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox-ssh" {
  security_group_id = "${openstack_networking_secgroup_v2.jumpbox.id}"

  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 22
  port_range_max   = 22
  remote_ip_prefix = "192.168.1.0/24"
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox-bosh" {
  security_group_id = "${openstack_networking_secgroup_v2.jumpbox.id}"

  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "tcp"
  port_range_min   = 6868
  port_range_max   = 6868
  remote_ip_prefix = "192.168.1.0/24"
}

resource "openstack_networking_secgroup_rule_v2" "jumpbox-icmp" {
  security_group_id = "${openstack_networking_secgroup_v2.jumpbox.id}"

  direction        = "ingress"
  ethertype        = "IPv4"
  protocol         = "icmp"
  remote_ip_prefix = "192.168.1.0/24"
}
