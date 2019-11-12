variable "physical_network" {}
variable "network_type" {}

variable "external_subnet_cidr" {}
variable "external_subnet_gateway" {}
variable "external_subnet_dns" {}
variable "external_subnet_allocation_start" {}
variable "external_subnet_allocation_end" {}

variable "internal_subnet_cidr" {}
variable "internal_subnet_gateway" {}

variable "lb_mgmt_subnet_cidr" {}
variable "lb_mgmt_subnet_gateway" {}
variable "lb_mgmt_subnet_allocation_start" {}
variable "lb_mgmt_subnet_allocation_end" {}
