resource "openstack_lb_loadbalancer_v2" "concourse_lb" {
  name          = "concourse_lb"
  vip_subnet_id = "${openstack_networking_subnet_v2.lb-mgmt-net-subnet.id}"
}

resource "openstack_lb_listener_v2" "concourse_lb" {
  name            = "concourse_lb"
  loadbalancer_id = "${openstack_lb_loadbalancer_v2.concourse_lb.id}"
  protocol        = "HTTP"
  protocol_port   = 80
}

resource "openstack_networking_floatingip_v2" "concourse_lb" {
  pool    = "${openstack_networking_network_v2.external.name}"
  port_id = "${openstack_lb_loadbalancer_v2.concourse_lb.vip_port_id}"
}

resource "openstack_lb_pool_v2" "concourse_lb" {
  name        = "concourse_lb"
  listener_id = "${openstack_lb_listener_v2.concourse_lb.id}"
  protocol    = "HTTP"
  lb_method   = "ROUND_ROBIN"

  persistence {
    type = "SOURCE_IP"
  }
}

resource "openstack_lb_monitor_v2" "concourse_lb" {
  name           = "concourse_lb"
  pool_id        = "${openstack_lb_pool_v2.concourse_lb.id}"
  type           = "HTTP"
  url_path       = "/"
  expected_codes = "200"
  delay          = 20
  timeout        = 10
  max_retries    = 5
}
