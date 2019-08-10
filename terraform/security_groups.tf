resource "openstack_networking_secgroup_v2" "vms_seruciry_group" {
  name                 = "vms_security_group"
  region               = "${var.region_name}"
  delete_default_rules = true
}

resource "openstack_networking_secgroup_rule_v2" "vms_egress" {
  direction         = "egress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
}

resource "openstack_networking_secgroup_rule_v2" "vms_ingress" {
  direction         = "ingress"
  ethertype         = "IPv4"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = "${openstack_networking_secgroup_v2.vms_seruciry_group.id}"
}
