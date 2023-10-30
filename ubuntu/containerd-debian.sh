#!/bin/bash
#https://github.com/containerd/containerd/blob/main/docs/getting-started.md
echo "=====install containerd ====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-${CONTAINERD_VERSION:-"1.7.7"}}
RELEASE=${VERSION::-2}
ARCH=$(uname -m)
ARCH_NAME=$(dpkg --print-architecture)

# requires runc,cniplugins
 #https://github.com/containerd/containerd/releases/download/v1.7.7/containerd-1.7.7-linux-amd64.tar.gz
# get containerd
wget --quiet https://github.com/containerd/containerd/releases/download/v${VERSION}/containerd-${VERSION}-linux-${ARCH_NAME}.tar.gz
tar Cxzvf /usr/local containerd-${VERSION}-linux-${ARCH_NAME}.tar.gz
rm containerd-${VERSION}-linux-${ARCH_NAME}.tar.gz

# create default service
curl -L https://raw.githubusercontent.com/containerd/containerd/release/${RELEASE}/containerd.service -o /etc/systemd/system/containerd.service

# create default config
mkdir -p /etc/containerd/
containerd config default | tee /etc/containerd/config.toml

# start service
systemctl daemon-reload
systemctl start containerd
systemctl enable containerd

echo "===== containerd done ====="
