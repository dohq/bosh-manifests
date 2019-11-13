#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

uaac target https://${UAA_ADDRESS}:8443 \
  --ca-cert <(bosh int bosh-creds/bosh-creds.yml --path=/uaa_ssl/ca)
uaac token client get admin \
  -s $(bosh int bosh-creds/bosh-creds.yml --path=/uaa_admin_client_secret)

uaac client delete atc_to_credhub
uaac client add atc_to_credhub \
  --name atc_to_credhub \
  --secret ${ATC_TO_CREDHUB_SECRET} \
  --authorized_grant_types client_credentials \
  --authorities credhub.write,credhub.read \
  --access_token_validity 3600
