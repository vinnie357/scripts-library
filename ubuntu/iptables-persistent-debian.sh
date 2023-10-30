#!/bin/bash
echo "=====install itables-persistent===="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# itables-persistent
DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent
echo "===== itables-persistent done ====="
