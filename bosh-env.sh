# common
export INTERNAL_CIDR=$(jq -r '.outputs.internal_cidr.value' ${TFSTATE})
export INTERNAL_GW=$(jq -r '.outputs.internal_gw.value' ${TFSTATE})
export NET_ID=$(jq -r '.outputs.net_id.value' ${TFSTATE})
export DEFAULT_KEY_NAME=$(jq -cr '.outputs.default_key_name.value' ${TFSTATE})

# Concourse lite
export LITE_INTERNAL_IP=$(jq -r '.outputs.lite_internal_ip.value' ${TFSTATE})
export LITE_PUBLIC_IP=$(jq -r '.outputs.lite_concourse_external_ip.value' ${TFSTATE})
export LITE_DEFAULT_SECURITY_GROUPS=$(jq -cr '.outputs.lite_security_group.value' ${TFSTATE})

# BOSH
export BOSH_INTERNAL_IP=$(jq -r '.outputs.bosh_internal_ip.value' ${TFSTATE})
export BOSH_DEFAULT_SECURITY_GROUPS=$(jq -cr '.outputs.vms_security_group.value' ${TFSTATE})
