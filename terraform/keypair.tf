resource "openstack_compute_keypair_v2" "bosh" {
  region     = "${var.region_name}"
  name       = "bosh"
  public_key = "${replace("${file("../bosh.pub")}", "\n", "")}"
}
