#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


# vars
url=$(bosh int bosh-deployment/openstack/cpi.yml --path=/name=stemcell/value/url)
ver="$(echo $url | cut -d "/" -f 5)"
heavy_stemcell="$(echo $url | cut -d "/" -f 6)"
light_stemcell="lite-bosh-stemcell-$ver-openstack-kvm-ubuntu-xenial-go_agent.tgz"
stemcell_id="$(openstack image list -f value| grep $ver | cut -d " " -f 1)"

# Download new stemcells
echo "Check alrady heavy stemcell file"

if [[ ! -f stemcells/$heavy_stemcell ]]; then
  echo "start $heavy_stemcell Download"
  curl -fsSL -O $url -o stemcells/$heavy_stemcell
  echo "Finished $heavy_stemcell Download"
fi

# create light stemcell
echo "Start create light stemcell"
bosh repack-stemcell --version $ver \
--empty-image \
--format openstack-light \
--cloud-properties="{\"image_id\": \"$stemcell_id\"}" \
stemcells/$heavy_stamcell stemcells/$light_stamcell
echo "Finished create light stemcell"

# upload bosh
bosh upload-stemcell stemcells/$light_stamcell
