resource "openstack_compute_keypair_v2" "vms" {
  name       = "vms"
  public_key = "${replace("${file("../bosh.pub")}", "\n", "")}"
}
