#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

bosh create-env bosh-deployment/bosh.yml \
  --ops-file bosh-deployment/virtualbox/cpi.yml \
  --ops-file bosh-deployment/virtualbox/outbound-network.yml \
  --ops-file bosh-deployment/bosh-lite.yml \
  --ops-file bosh-deployment/uaa.yml \
  --ops-file bosh-deployment/credhub.yml \
  --ops-file bosh-deployment/jumpbox-user.yml \
  --var director_name=bosh-lite \
  --var internal_ip=192.168.50.6 \
  --var internal_gw=192.168.50.1 \
  --var internal_cidr=192.168.50.0/24 \
  --var outbound_network_name=NatNetwork \
  --vars-store ${PWD}/bosh-lite-creds.yml \
  --state ${PWD}/bosh-lite-state.json

if [[ $(ip route | grep 192.168.50.6 | wc -l) -e 0 ]]; then
  sudo ip route add 10.244.0.0/16 via 192.168.50.6
fi
cat > .bosh-lite-envrc <<EOF
export BOSH_ENVIRONMENT=192.168.50.6
export BOSH_CA_CERT=\$( bosh interpolate ${PWD}/bosh-lite-creds.yml --path /director_ssl/ca )
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=\$( bosh interpolate ${PWD}/bosh-lite-creds.yml --path /admin_password )

export CREDHUB_SERVER=https://192.168.50.6:8844
export CREDHUB_CA_CERT="\$( bosh interpolate ${PWD}/bosh-lite-creds.yml --path=/credhub_tls/ca )
\$( bosh interpolate ${PWD}/bosh-lite-creds.yml --path=/uaa_ssl/ca )"
export CREDHUB_CLIENT=credhub-admin
export CREDHUB_SECRET=\$( bosh interpolate ${PWD}/bosh-lite-creds.yml --path=/credhub_admin_client_secret )
EOF

source .bosh-lite-envrc
bosh -n update-cloud-config bosh-deployment/warden/cloud-config.yml \
  > /dev/null

bosh -n update-runtime-config bosh-deployment/runtime-configs/dns.yml \
  > /dev/null
