#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# get tf_output
pushd terraform/
tf_output=$(terraform output -json)
LITE_PUBLIC_IP=$(echo $tf_output | jq -r '.concourse_lite_fip.value')
popd

bosh int concourse-creds.yml --path /jumpbox_ssh/private_key > cj.pem
chmod 600 cj.pem
ssh -o 'StrictHostKeyChecking=no' -i cj.pem jumpbox@${LITE_PUBLIC_IP}
rm -rf cj.pem
