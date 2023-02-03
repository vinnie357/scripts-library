#!/bin/bash
echo "===wireguard==="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
export DEBIAN_FRONTEND=noninteractive

VERSION=${1:-"0.17.1"}
TOOLS=${2:-"true"}
DEPENDENCIES="wireguard"

if [ "$TOOLS" = "true" ]; then
  DEPENDENCIES="wireguard wireguard-tools"
fi

apt update
apt-get install -y $DEPENDENCIES

echo "=====finished wireguard====="
