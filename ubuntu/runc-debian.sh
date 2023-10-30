#!/bin/bash
echo "=====install runc ====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-${RUNC_VERSION:-"1.1.9"}}
ARCH=$(uname -m)
ARCH_NAME=$(dpkg --print-architecture)

wget --quiet https://github.com/opencontainers/runc/releases/download/v${VERSION}/runc.${ARCH_NAME}
sudo install -m 755 runc.${ARCH_NAME} /usr/local/sbin/runc
rm runc.${ARCH_NAME}

echo "===== runc done ====="
