#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


cd terraform
terraform apply plan

DATE=$(date '+%Y%m%d%H%M%S')
mcli cp terraform.tfstate "${TFSTATE_BUCKET}"/terraform-${DATE}.tfstate
