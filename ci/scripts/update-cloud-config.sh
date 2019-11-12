#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


cp bosh-creds/bosh-creds.yml template/

cd template
source bosh-env.sh
export BOSH_CLIENT=admin
export BOSH_CLIENT_SECRET=$(bosh int bosh-creds.yml --path=/admin_password)
export BOSH_ENVIRONMENT=$BOSH_INTERNAL_IP
export BOSH_CA_CERT=bosh.pem
bosh int bosh-creds.yml --path=/director_ssl/ca > bosh.pem
chmod 600 bosh.pem

bosh env
./update-cloud-config.sh
