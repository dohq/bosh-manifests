#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


cd terraform
terraform plan -out plan
