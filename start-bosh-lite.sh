#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

VBoxManage startvm $(bosh int ./bosh-lite-state.json --path=/current_vm_cid) --type headless
