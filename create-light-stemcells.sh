#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


# vars
url=$(bosh int bosh-deployment/openstack/cpi.yml --path=/name=stemcell/value/url)
ver="$(echo $url | cut -d "/" -f 5)"
heavy_stemcell_name="$(echo $url | cut -d "/" -f 6)"
light_stemcell_name="lite-bosh-stemcell-$ver-openstack-kvm-ubuntu-xenial-go_agent.tgz"
stemcell_id="$(openstack image list -f value| grep $ver | cut -d " " -f 1)"
heavy_stamcell=stemcells/$heavy_stemcell_name
light_stamcell=stemcells/$light_stemcell_name

# Download new stemcells
echo "Check alrady light stemcell file"

if [[ ! -f stemcells/$heavy_stemcell_name ]]; then
  echo "start $heavy_stemcell_name Download"
  curl -fsSL -O $url -o stemcells/$heavy_stemcell_name
  echo "Finished $heavy_stemcell_name Download"
fi

# create light stemcell
echo "Start create light stemcell"
bosh repack-stemcell --version $ver \
--empty-image \
--format openstack-light \
--cloud-properties="{\"image_id\": \"$stemcell_id\"}" \
$heavy_stamcell $light_stamcell
echo "Finished create light stemcell"

# upload bosh
bosh upload-stemcell $light_stamcell
