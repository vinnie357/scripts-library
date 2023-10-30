#!/bin/bash
echo "=====install crictl ====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-${NERCTL_VERSION:-"1.28.0"}} # check latest version in /releases page
ARCH_NAME=$(dpkg --print-architecture)
#https://github.com/kubernetes-sigs/cri-tools/releases/download/1.28.0/crictl-v1.28.0-linux-amd64.tar.gz
curl -sL https://github.com/kubernetes-sigs/cri-tools/releases/download/v$VERSION/crictl-v${VERSION}-linux-${ARCH_NAME}.tar.gz --output crictl-v${VERSION}-linux-${ARCH_NAME}.tar.gz
tar zxf crictl-v$VERSION-linux-${ARCH_NAME}.tar.gz -C /usr/local/bin
rm -f crictl-$VERSION-linux-amd64.tar.gz

echo "===== crictl done ====="
