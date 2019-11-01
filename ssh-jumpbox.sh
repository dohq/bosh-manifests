#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# get tf_output
pushd terraform/
tf_output=$(terraform output -json)
JUMPBOX_PUBLIC_IP=$(echo $tf_output | jq -r '.jumpbox_fip.value')
popd

bosh int jumpbox-creds.yml --path /jumpbox_ssh/private_key > cj.pem
chmod 600 cj.pem
ssh -o 'StrictHostKeyChecking=no' -i cj.pem jumpbox@${JUMPBOX_PUBLIC_IP}
rm -rf cj.pem
