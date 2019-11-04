pushd terraform/
terraform init
tf_output=$(terraform output -json)

# common
export INTERNAL_CIDR=$(echo $tf_output | jq -r '.internal_cidr.value')
export INTERNAL_GW=$(echo $tf_output | jq -r '.internal_gw.value')
export NET_ID=$(echo $tf_output | jq -r '.internal_net_id.value')
export DEFAULT_SECURITY_GROUPS=$(echo $tf_output | jq -r '.vms_secgroup_name.value')
export DEFAULT_KEY_NAME=$(echo $tf_output | jq -r '.vms_keypair_name.value')

# jumbox lite
export JUMPBOX_INTERNAL_IP=$(echo $tf_output | jq -r '.jumpbox_internal_ip.value')
export JUMPBOX_EXTERNAL_IP=$(echo $tf_output | jq -r '.jumpbox_fip.value')
export JUMPBOX_DEFAULT_SECURITY_GROUPS=$(echo $tf_output | jq -r '.jumpbox_secgroup_name.value')

# BOSH
export BOSH_INTERNAL_IP=$(echo $tf_output | jq -r '.bosh_internal_ip.value')
popd
