output "internal_cidr" {
  value = "${openstack_networking_subnet_v2.private_subnet.cidr}"
}

output "internal_gw" {
  value = "${openstack_networking_subnet_v2.private_subnet.gateway_ip}"
}

output "net_id" {
  value = "${openstack_networking_network_v2.private.id}"
}

output "lite_internal_ip" {
  value = "${cidrhost(openstack_networking_subnet_v2.private_subnet.cidr, 10)}"
}

output "bosh_internal_ip" {
  value = "${cidrhost(openstack_networking_subnet_v2.private_subnet.cidr, 15)}"
}

output "router_id" {
  value = "${openstack_networking_router_v2.router.id}"
}

output "vms_security_group" {
  value = ["${openstack_networking_secgroup_v2.vms_seruciry_group.name}"]
}

output "lite_security_group" {
  value = ["${openstack_networking_secgroup_v2.lite_seruciry_group.name}"]
}

output "default_key_name" {
  value = "${openstack_compute_keypair_v2.bosh.name}"
}

output "lite_concourse_external_ip" {
  value = "${openstack_networking_floatingip_v2.lite_concourse.address}"
}
