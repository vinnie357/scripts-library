#!/bin/bash
echo "=====install cni-plugins ====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-${CNI_VERSION:-"1.2.0"}}

curl -L -o cni-plugins.tgz "https://github.com/containernetworking/plugins/releases/download/v${VERSION}/cni-plugins-linux-$([ $(uname -m) = aarch64 ] && echo arm64 || echo amd64)"-v${VERSION}.tgz
mkdir -p /opt/cni/bin
tar -C /opt/cni/bin -xzf cni-plugins.tgz
rm -f cni-plugins.tgz

echo "===== cni-plugins done ====="
