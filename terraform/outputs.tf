# aws
output "bosh_creds_bucket" {
  value = "${aws_s3_bucket.bosh-creds.bucket}"
}
output "tfstate_bucket" {
  value = "dohq-openstack-tfstate"
}

# openstack
output "internal_net_id" {
  value = "${openstack_networking_network_v2.internal.id}"
}

output "internal_cidr" {
  value = "${openstack_networking_subnet_v2.internal-subnet.cidr}"
}

output "internal_gw" {
  value = "${openstack_networking_subnet_v2.internal-subnet.gateway_ip}"
}

output "jumpbox_internal_ip" {
  value = "${cidrhost(openstack_networking_subnet_v2.internal-subnet.cidr, 5)}"
}

output "jumpbox_fip" {
  value = "${openstack_networking_floatingip_v2.jumpbox.address}"
}

output "bosh_internal_ip" {
  value = "${cidrhost(openstack_networking_subnet_v2.internal-subnet.cidr, 10)}"
}

output "vms_keypair_name" {
  value = "${openstack_compute_keypair_v2.vms.name}"
}

output "vms_secgroup_name" {
  value = "${openstack_networking_secgroup_v2.vms.name}"
}

output "amp_boot_network_list" {
  value = "${openstack_networking_network_v2.lb-mgmt-net.id}"
}

output "amp_secgroup_id" {
  value = "${openstack_networking_secgroup_v2.lb-mgmt-sec-grp.id}"
}

output "amp_flavor_id" {
  value = "${openstack_compute_flavor_v2.amphora.id}"
}

# deployment
output "concourse_fip" {
  value = "${openstack_networking_floatingip_v2.concourse_lb.address}"
}
