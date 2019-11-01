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
