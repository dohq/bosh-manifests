# input variables
variable "ext_net_id" {}

variable "availability_zone" {}

variable "dns_nameservers" {
  default = ["8.8.8.8"]
  type    = "list"
}

# access coordinates/credentials
variable "auth_url" {}

variable "user_name" {}

variable "password" {}

variable "domain_name" {}

variable "tenant_name" {}

variable "insecure" {
  default = "false"
}

variable "cacert_file" {
  default = ""
}

# external network coordinates
variable "ext_net_name" {}

# region/zone coordinates
variable "region_name" {}

# key pair
variable "keypair_suffix" {
  default = ""
}

# security group
variable "security_group_suffix" {
  default = ""
}

# CIDR vers
variable "flat_cidr" {}
