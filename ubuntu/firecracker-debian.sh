#!/bin/bash
echo "=====install firecracker====="
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# install firecracker
release_url="https://github.com/firecracker-microvm/firecracker/releases"
latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective} ${release_url}/latest))
arch=`uname -m`
curl -L ${release_url}/download/${latest}/firecracker-${latest}-${arch}.tgz \
| tar -xz
mv release-${latest}-$(uname -m) firecracker
cp firecracker/firecracker-${latest}-$(uname -m) /usr/bin/firecracker
firecracker --version
echo "==== firecracker done ===="
