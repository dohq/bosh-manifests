#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# source common env
source ./bosh-env.sh

# export BOSH_LOG_LEVEL=debug
bosh update-cloud-config bosh-deployment/openstack/cloud-config.yml \
  -o ops-files/cloud-config-add-vm-types.yml \
  -o ops-files/dns.yml \
  -v az=nova \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v net_id=${NET_ID} \
  $@
