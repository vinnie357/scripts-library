#!/bin/bash
echo "=====install qemu====="
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# run update
apt-get update
# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive
# install qemu
apt-get install -y \
qemu qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

echo "==== qemu done ===="
