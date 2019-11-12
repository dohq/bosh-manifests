#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'


rm -rf ~/.bosh
ln -s $PWD/bosh $HOME/.bosh

cp bosh-creds/bosh-creds.yml template/
cp bosh-state/bosh-state.json template/

cd template
echo "$BOSH_PEM" > bosh.pem
chmod 600 bosh.pem

sed -e 's/create-env/delete-env/g' deploy-bosh.sh > destroy-bosh.sh
chmod +x destroy-bosh.sh

./destroy-bosh.sh
ret=$?

echo '{}' > bosh-state.json

cp bosh-creds.yml ../out/
cp bosh-state.json ../out/

if [[ $ret -ne 0 ]];then
  exit 1
fi
