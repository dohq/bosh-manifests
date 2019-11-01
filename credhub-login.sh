#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# get tf_output
pushd terraform/
tf_output=$(terraform output -json)
LITE_PUBLIC_IP=$(echo $tf_output | jq -r '.concourse_lite_fip.value')
popd

credhub login -s https://"${LITE_PUBLIC_IP}":8844 \
  --client-name=atc_to_credhub \
  --client-secret=$(bosh int ./concourse-creds.yml --path=/credhub_client_secret) \
  --ca-cert=<(bosh int ./concourse-creds.yml --path=/uaa_tls/ca) \
  --ca-cert=<(bosh int ./concourse-creds.yml --path=/credhub_tls/ca)
