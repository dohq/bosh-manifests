#!/usr/bin/env bash
set -euo pipefail

# read env
source bosh-env.sh

# export BOSH_LOG_LEVEL=debug
# bosh delete-env jumpbox-deployment/jumpbox.yml \
# bosh int jumpbox-deployment/jumpbox.yml \
bosh create-env jumpbox-deployment/jumpbox.yml \
  -o jumpbox-deployment/openstack/cpi.yml \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v internal_ip=${JUMPBOX_INTERNAL_IP} \
  -v external_ip=${JUMPBOX_EXTERNAL_IP} \
  -v az=nova \
  -v net_id=${NET_ID} \
  -v auth_url=${OS_AUTH_URL} \
  -v openstack_username=${OS_USERNAME} \
  -v openstack_password=${OS_PASSWORD} \
  -v openstack_domain=${OS_USER_DOMAIN_NAME} \
  -v openstack_project=${OS_PROJECT_NAME} \
  -v region=${OS_REGION_NAME} \
  -v default_key_name=${DEFAULT_KEY_NAME} \
  -v default_security_groups=[${JUMPBOX_DEFAULT_SECURITY_GROUPS}] \
  -v external_host=${JUMPBOX_EXTERNAL_IP} \
  --var-file private_key=bosh.pem \
  --vars-store jumpbox-creds.yml \
  --state jumpbox-state.json $@
