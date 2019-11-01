resource "openstack_compute_keypair_v2" "vms" {
  name       = "vms"
  public_key = "${replace("${file("../bosh.pub")}", "\n", "")}"
}

resource "openstack_compute_keypair_v2" "jumpbox" {
  name       = "jumpbox"
  public_key = "${replace("${file("${data.environment_variable.HOME.value}/.ssh/id_rsa.pub")}", "\n", "")}"
}
