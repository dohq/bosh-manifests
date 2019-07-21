#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

source ./bosh-env.sh

echo https://${LITE_PUBLIC_IP}
echo concourse
echo $(bosh int ./concourse-creds.yml --path=/concourse_password)

fly login -t lite -k -c https://${LITE_PUBLIC_IP} -u concourse -p $(bosh int ./concourse-creds.yml --path=/concourse_password)
