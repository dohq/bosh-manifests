#!/usr/bin/env bash
set -euo pipefail

# source common env
source ./bosh-env.sh

# export BOSH_LOG_LEVEL=debug
bosh create-env concourse-bosh-deployment/lite/concourse.yml \
  -l concourse-bosh-deployment/versions.yml \
  -o concourse-bosh-deployment/lite/infrastructures/openstack.yml \
  -o concourse-bosh-deployment/lite/jumpbox.yml \
  -o <(sed 's|/instance_groups/name=web|/instance_groups/name=concourse|g' concourse-bosh-deployment/cluster/operations/tls-vars.yml) \
  -o <(sed 's|/instance_groups/name=web|/instance_groups/name=concourse|g' concourse-bosh-deployment/cluster/operations/tls.yml) \
  -o <(sed 's|/instance_groups/name=web|/instance_groups/name=concourse|g' concourse-bosh-deployment/cluster/operations/privileged-https.yml) \
  -o <(sed 's|/instance_groups/name=web|/instance_groups/name=concourse|g' concourse-bosh-deployment/cluster/operations/github-auth.yml) \
  -o ops-files/lite-bump-releases.yml \
  -o ops-files/lite-instance-size.yml \
  -o ops-files/lite-readable-vm-names.yml \
  -o ops-files/lite-networks.yml \
  -o ops-files/lite-uaa.yml \
  -o ops-files/lite-credhub.yml \
  -o ops-files/lite-add-credhub-users.yml \
  -o ops-files/syslog.yml \
  -v internal_cidr=${INTERNAL_CIDR} \
  -v internal_gw=${INTERNAL_GW} \
  -v internal_ip=${LITE_INTERNAL_IP} \
  -v public_ip=${LITE_PUBLIC_IP} \
  -v az=nova \
  -v net_id=${NET_ID} \
  -v auth_url=${OS_AUTH_URL} \
  -v openstack_username=${OS_USERNAME} \
  -v openstack_password=${OS_PASSWORD} \
  -v openstack_domain=${OS_USER_DOMAIN_NAME} \
  -v openstack_project=${OS_PROJECT_NAME} \
  -v region=${OS_REGION_NAME} \
  -v default_key_name=${DEFAULT_KEY_NAME} \
  -v default_security_groups=${LITE_DEFAULT_SECURITY_GROUPS} \
  -v external_host=${LITE_PUBLIC_IP} \
  -v syslog_address=${SYSLOG_HOST} \
  -v syslog_port=${SYSLOG_PORT} \
  -v syslog_transport=tcp \
  -v github_client.username=${GITHUB_CLIENT} \
  -v github_client.password=${GITHUB_SECRET} \
  -v main_team.github_users=${GITHUB_USERNAME} \
  -v main_team.github_orgs=main \
  -v main_team.github_teams=main \
  -v credhub_client_id=atc_to_credhub \
  --var-file private_key=bosh.pem \
  --vars-store concourse-creds.yml \
  --state concourse-state.json \
  $@

# upload object storage creds
mc cp concourse-{creds.yml,state.json} "${LITE_CREDS_BUCKET}"
