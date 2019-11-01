#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# get tf_output
pushd terraform/
tf_output=$(terraform output -json)
LITE_PUBLIC_IP=$(echo $tf_output | jq -r '.concourse_lite_fip.value')
popd

# uaac target "${LITE_PUBLIC_IP}":8443 --skip-ssl-validation
uaac target https://"${LITE_PUBLIC_IP}":8443 --ca-cert <(bosh int ./concourse-creds.yml --path /uaa_tls/ca)
uaac token client get uaa_admin -s $(bosh int ./concourse-creds.yml --path /uaa_admin_client_secret)
