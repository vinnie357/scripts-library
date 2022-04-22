#!/bin/bash
echo "=====install base====="
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# run update
apt-get update
# Ensure apt is in non-interactive to avoid prompts
export DEBIAN_FRONTEND=noninteractive
# install base
apt-get install -y \
software-properties-common \
gnupg2

echo "==== base done ===="
