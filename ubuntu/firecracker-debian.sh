#!/bin/bash
echo "=====install firecracker====="

DEFAULT_FC_PATH=${1:-"/opt/firecracker"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

mkdir -p "${DEFAULT_FC_PATH}/"{data,config,snakesandsparklers}

# install firecracker
release_url="https://github.com/firecracker-microvm/firecracker/releases"
latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective} ${release_url}/latest))
arch=`uname -m`
curl -L ${release_url}/download/${latest}/firecracker-${latest}-${arch}.tgz \
| tar -xz -C "${DEFAULT_FC_PATH}/"
mv ${DEFAULT_FC_PATH}/release-${latest}-$(uname -m) ${DEFAULT_FC_PATH}/bin
cp ${DEFAULT_FC_PATH}/bin/firecracker-${latest}-$(uname -m) /usr/bin/firecracker
cp ${DEFAULT_FC_PATH}/bin/jailer-${latest}-$(uname -m) /usr/bin/jailer
firecracker --version
jailer --version
echo "==== firecracker done ===="
