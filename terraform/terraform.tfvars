physical_network = "physnet1"
network_type     = "flat"

external_subnet_cidr             = "192.168.1.0/24"
external_subnet_gateway          = "192.168.1.1"
external_subnet_dns              = "192.168.1.254"
external_subnet_allocation_start = "192.168.1.25"
external_subnet_allocation_end   = "192.168.1.99"

internal_subnet_cidr    = "10.0.0.0/24"
internal_subnet_gateway = "10.0.0.1"

lb_mgmt_subnet_cidr             = "172.32.0.0/12"
lb_mgmt_subnet_gateway          = "172.32.0.1"
lb_mgmt_subnet_allocation_start = "172.32.0.100"
lb_mgmt_subnet_allocation_end   = "172.32.31.254"
