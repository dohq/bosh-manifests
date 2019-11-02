#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


# vars
url=$(bosh int ../bosh-deployment/openstack/cpi.yml --path=/name=stemcell/value/url)
ver="$(echo $url | cut -d "/" -f 5)"
filename="$(echo $url | cut -d "/" -f 6)"
light_stemcell_name="lite-bosh-stemcell-$ver-openstack-kvm-ubuntu-xenial-go_agent.tgz"
stemcell_id="$(openstack image list -f value| grep $ver | cut -d " " -f 1)"

# trap
# trap "rm -rf $tmp_dir; exit 1" 1 2 3 15

# Download new stemcells
echo "Check alrady light stemcell file"

if [[ ! -f $filename ]]; then
  echo "start $filename Download"
  curl -fsSL -o $filename $url
  echo "end $filename Download: $filename"
fi

# create light stemcell
echo "Stat create light stemcell"
bosh repack-stemcell --version $ver \
--empty-image \
--format openstack-light \
--cloud-properties="{\"image_id\": \"$stemcell_id\"}" \
$filename ./$light_stemcell_name

# end
rm -rf $tmp_dir
echo "Finished create light stemcell"
