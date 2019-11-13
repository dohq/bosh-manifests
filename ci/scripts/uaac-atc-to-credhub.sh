#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


cp bosh-creds/bosh-creds.yml template/
cd template
source bosh-env.sh

uaac target https://${BOSH_INTERNAL_IP}:8443
uaac token client get admin \
  -s $(bosh int bosh-creds.yml --path=/uaa_admin_client_secret)
  --ca-cert <(bosh int bosh-creds.yml --path=/uaa_ca/ca)

uaac client delete atc_to_credhub
uaac client add atc_to_credhub \
  --name atc_to_credhub \
  --secret ${ATC_TO_CREDHUB_SECRET} \
  --authorized_grant_types client_credentials \
  --authorities credhub.write,credhub.read \
  --access_token_validity 3600
