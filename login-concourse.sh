#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

source ./bosh-env.sh

echo https://${JUMPBOX_EXTERNAL_IP}
echo concourse
echo $(bosh int ./concourse-creds.yml --path=/concourse_password)

fly login -t lite -k -c https://${JUMPBOX_EXTERNAL_IP} -u concourse -p $(bosh int ./concourse-creds.yml --path=/concourse_password)
