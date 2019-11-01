output "tfstate_bucket" {
  value = "dohq-openstack-tfstate"
}

output "internal_net_id" {
  value = "${openstack_networking_network_v2.internal.id}"
}

output "internal_cidr" {
  value = "${openstack_networking_subnet_v2.internal-subnet.cidr}"
}

output "internal_gw" {
  value = "${openstack_networking_subnet_v2.internal-subnet.gateway_ip}"
}

output "concourse_lite_internal_ip" {
  value = "${cidrhost(openstack_networking_subnet_v2.internal-subnet.cidr, 5)}"
}

output "concourse_lite_fip" {
  value = "${openstack_networking_floatingip_v2.concourse-lite.address}"
}

output "bosh_keypair_name" {
  value = "${openstack_compute_keypair_v2.bosh.name}"
}

output "bosh_secgroup_name" {
  value = "${openstack_networking_secgroup_v2.vms.name}"
}
