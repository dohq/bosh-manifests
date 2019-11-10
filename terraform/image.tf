resource "openstack_images_image_v2" "cirros" {
  name             = "cirros"
  image_source_url = "http://download.cirros-cloud.net/${var.cirros-version}/cirros-${var.cirros-version}-x86_64-disk.img"
  container_format = "bare"
  disk_format      = "qcow2"
}

resource "openstack_images_image_v2" "xenial" {
  name             = "xenial"
  image_source_url = "http://cloud-images.ubuntu.com/xenial/current/xenial-server-cloudimg-amd64-disk1.img"
  container_format = "bare"
  disk_format      = "qcow2"
}
