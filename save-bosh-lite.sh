#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

VBoxManage controlvm $(bosh int ./bosh-lite-state.json --path=/current_vm_cid) savestate
