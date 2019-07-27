#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

source ./bosh-env.sh

# uaac target "${LITE_PUBLIC_IP}":8443 --skip-ssl-validation
uaac target https://"${LITE_PUBLIC_IP}":8443 --ca-cert <(bosh int ./concourse-creds.yml --path /uaa_tls/ca)
uaac token client get uaa_admin -s $(bosh int ./concourse-creds.yml --path /uaa_admin_client_secret)
