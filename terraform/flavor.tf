# --ram 512 --disk 1 --vcpus 1 m1.tiny
# --ram 2048 --disk 20 --vcpus 1 m1.small
# --ram 4096 --disk 40 --vcpus 2 m1.medium
# --ram 8192 --disk 80 --vcpus 4 m1.large
# --ram 16384 --disk 160 --vcpus 8 m1.xlarge

resource "openstack_compute_flavor_v2" "amphora" {
  name      = "amphora"
  is_public = true
  vcpus     = 1
  ram       = 512
  disk      = 5
}

resource "openstack_compute_flavor_v2" "nano" {
  name      = "m1.nano"
  is_public = true
  vcpus     = 1
  ram       = 512
  disk      = 5
}

resource "openstack_compute_flavor_v2" "micro" {
  name      = "m1.micro"
  is_public = true
  vcpus     = 1
  ram       = 1024
  disk      = 10
}

resource "openstack_compute_flavor_v2" "small" {
  name      = "m1.small"
  is_public = true
  vcpus     = 2
  ram       = 2048
  disk      = 20
}

resource "openstack_compute_flavor_v2" "medium" {
  name      = "m1.medium"
  is_public = true
  vcpus     = 2
  ram       = 4096
  disk      = 40
}

resource "openstack_compute_flavor_v2" "large" {
  name      = "m1.large"
  is_public = true
  vcpus     = 2
  ram       = 8192
  disk      = 80
}

resource "openstack_compute_flavor_v2" "xlarge" {
  name      = "m1.xlarge"
  is_public = true
  vcpus     = 4
  ram       = 16384
  disk      = 160
}
