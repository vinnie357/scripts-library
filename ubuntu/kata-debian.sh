#!/bin/bash
echo "=====install kata-containers ====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-${KATA_VERSION:-"3.2.0"}}
ARCH=$(uname -m)
ARCH_NAME=$(dpkg --print-architecture)

wget --quiet https://github.com/kata-containers/kata-containers/releases/download/${VERSION}/kata-static-${VERSION}-${ARCH_NAME}.tar.xz
xzcat kata-static-${VERSION}-${ARCH_NAME}.tar.xz | tar -xf - -C /
rm kata-static-${VERSION}-${ARCH_NAME}.tar.xz

ln -s /opt/kata/bin/kata-runtime /usr/bin
ln -s /opt/kata/bin/containerd-shim-kata-v2 /usr/bin

echo "===== kata-containers done ====="
