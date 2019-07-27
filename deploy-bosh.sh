#!/usr/bin/env bash
set -euo pipefail

# source common env
source ./bosh-env.sh

# export BOSH_LOG_LEVEL=debug
bosh create-env bosh-deployment/bosh.yml \
  -o bosh-deployment/openstack/cpi.yml \
  -o bosh-deployment/jumpbox-user.yml \
  -o bosh-deployment/uaa.yml \
  -o bosh-deployment/credhub.yml \
  -o bosh-deployment/syslog.yml \
  -o ops-files/lite-instance-size.yml \
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
  -v default_security_groups=${BOSH_DEFAULT_SECURITY_GROUPS} \
  -v syslog_address=${SYSLOG_HOST} \
  -v syslog_port=${SYSLOG_PORT} \
  -v syslog_transport=tcp \
  --var-file private_key=bosh.pem \
  --state bosh-state.json \
  --vars-store bosh-creds.yml \
  $@
