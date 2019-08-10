#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


bosh int concourse-creds.yml --path /jumpbox_ssh/private_key > cj.pem
chmod 600 cj.pem
ssh -o 'StrictHostKeyChecking=no' -i cj.pem jumpbox@$(terraform output -state=${TFSTATE} lite_concourse_external_ip)
rm -rf cj.pem
