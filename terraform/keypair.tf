resource "openstack_compute_keypair_v2" "bosh" {
  name       = "bosh"
  public_key = "${replace("${file("../bosh.pub")}", "\n", "")}"
}
