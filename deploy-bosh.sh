#!/usr/bin/env bash
set -euo pipefail

# get env
source bosh-env.sh

# export BOSH_LOG_LEVEL=debug
# bosh int bosh-deployment/bosh.yml \
# bosh delete-env bosh-deployment/bosh.yml \
bosh create-env bosh-deployment/bosh.yml \
  -o bosh-deployment/openstack/cpi.yml \
  -o bosh-deployment/jumpbox-user.yml \
  -o bosh-deployment/uaa.yml \
  -o bosh-deployment/credhub.yml \
  -o bosh-deployment/misc/cpi-resize-disk.yml \
  -o ops-files/bosh-instance-size.yml \
  -v director_name=bosh \
  -v az=nova \
  -v net_id=${NET_ID} \
  -v auth_url=${OS_AUTH_URL} \
  -v openstack_username=${OS_USERNAME} \
  -v openstack_password=${OS_PASSWORD} \
  -v openstack_domain=${OS_USER_DOMAIN_NAME} \
  -v openstack_project=${OS_PROJECT_NAME} \
  -v region=${OS_REGION_NAME} \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v internal_ip=${BOSH_INTERNAL_IP} \
  -v default_key_name=${DEFAULT_KEY_NAME} \
  -v default_security_groups=[${DEFAULT_SECURITY_GROUPS}] \
  --var-file private_key=bosh.pem \
  --vars-store bosh-creds.yml \
  --state bosh-state.json $@
