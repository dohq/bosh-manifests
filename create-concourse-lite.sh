#!/usr/bin/env bash
set -euo pipefail

export INTERNAL_CIDR=$(jq -r '.outputs.internal_cidr.value' ${TFSTATE})
export INTERNAL_GW=$(jq -r '.outputs.internal_gw.value' ${TFSTATE})
export INTERNAL_IP=$(jq -r '.outputs.internal_ip.value' ${TFSTATE})
export PUBLIC_IP=$(jq -r '.outputs.lite_concourse_external_ip.value' ${TFSTATE})
export NET_ID=$(jq -r '.outputs.net_id.value' ${TFSTATE})
export DEFAULT_SECURITY_GROUPS=$(jq -cr '.outputs.vms_security_group.value' ${TFSTATE})
export DEFAULT_KEY_NAME=$(jq -cr '.outputs.default_key_name.value' ${TFSTATE})

export BOSH_LOG_LEVEL=debug
bosh create-env concourse-bosh-deployment/lite/concourse.yml \
  -l concourse-bosh-deployment/versions.yml \
  -o concourse-bosh-deployment/lite/infrastructures/openstack.yml \
  -o concourse-bosh-deployment/lite/operations/debug.yml \
  -o ops-files/lite-concourse-bump-cpi-stemcell.yml \
  -o ops-files/lite-concourse-instance-size.yml \
  -o ops-files/lite-concourse-readable-vm-names.yml \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v internal_ip=${INTERNAL_IP} \
  -v public_ip=${PUBLIC_IP} \
  -v az=nova \
  -v net_id=${NET_ID} \
  -v auth_url=${OS_AUTH_URL} \
  -v openstack_username=${OS_USERNAME} \
  -v openstack_password=${OS_PASSWORD} \
  -v openstack_domain=${OS_USER_DOMAIN_NAME} \
  -v openstack_project=${OS_PROJECT_NAME} \
  -v region=${OS_REGION_NAME} \
  -v default_key_name=${DEFAULT_KEY_NAME} \
  -v default_security_groups=${DEFAULT_SECURITY_GROUPS} \
  --var-file private_key=bosh.pem \
  --state concourse-state.json \
  --vars-store concourse-creds.yml
