#!/bin/bash
echo "=====install cloud-hypervisor ====="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-${CLOUDHYPERVISOR_VERSION:-"35.0"}}

curl -sL https://github.com/cloud-hypervisor/cloud-hypervisor/releases/download/v${VERSION}/cloud-hypervisor-static -o cloud-hypervisor
chmod +x cloud-hypervisor
mv cloud-hypervisor /usr/local/bin

echo "===== cloud-hypervisor done ====="
