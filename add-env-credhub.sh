#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


while read line
do
  env_name="$(echo $line | cut -d ' ' -f 2 | cut -d '=' -f 1 | tr '[:upper:]' '[:lower:]')"
  env_value="$(echo $line | cut -d ' ' -f 2 | cut -d '=' -f 2)"
  credhub set -n /concourse/main/$env_name -t value -v $env_value
done < ./admin-openrc.sh
credhub set -n /concourse/main/initialize/bosh_pem -t ssh -p bosh.pem -u bosh.pub
credhub set -n /concourse/main/initialize/bosh_creds_bucket -t value -v $BOSH_CREDS_BUCKET
credhub set -n /concourse/main/aws_access_key -t value -v $AWS_ACCESS_KEY
credhub set -n /concourse/main/aws_secret_key -t value -v $AWS_SECRET_KEY
credhub set -n /concourse/main/aws_region -t value -v $AWS_REGION
credhub set -n /concourse/main/slack_webhook -t value -v $SLACK_WEBHOOK
