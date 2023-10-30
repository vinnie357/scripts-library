#!/bin/bash
echo "=====install nerdctl ====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-${NERCTL_VERSION:-"1.6.2"}}
ARCH_NAME=$(dpkg --print-architecture)
#https://github.com/containerd/nerdctl/releases/download/v1.6.2/nerdctl-full-1.6.2-linux-arm64.tar.gz
#https://github.com/containerd/nerdctl/releases/download/v1.6.2/nerdctl-1.6.2-linux-arm64.tar.gz
wget --quiet https://github.com/containerd/nerdctl/releases/download/v${VERSION}/nerdctl-${VERSION}-linux-${ARCH_NAME}.tar.gz
tar zxf nerdctl-${VERSION}-linux-${ARCH_NAME}.tar.gz nerdctl -C /usr/local/bin
rm nerdctl-${VERSION}-linux-${ARCH_NAME}.tar.gz

echo "===== nerdctl done ====="
