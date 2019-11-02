#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# get tf_output
pushd terraform/
tf_output=$(terraform output -json)
INTERNAL_CIDR=$(echo $tf_output | jq -r '.internal_cidr.value')
INTERNAL_GW=$(echo $tf_output | jq -r '.internal_gw.value')
NET_ID=$(echo $tf_output | jq -r '.internal_net_id.value')
popd

# export BOSH_LOG_LEVEL=debug
bosh update-cloud-config bosh-deployment/openstack/cloud-config.yml \
  -o ops-files/cloud-config-add-vm-types.yml \
  -o ops-files/dns.yml \
  -v az=nova \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v net_id=${NET_ID} \
  $@
