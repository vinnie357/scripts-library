#!/bin/bash
echo "---installing python/pip---"

pythonVersion=${1:-"3.8"}
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
export DEBIAN_FRONTEND=noninteractive
apt-get update 
apt-get -y install --no-install-recommends \
    python${pythonVersion}-minimal \
    python3-pip
ln -sf /usr/bin/python3 /usr/bin/python
python3 -m pip install --no-cache-dir --upgrade pip
ln -sf /usr/bin/pip3 /usr/bin/pip
echo "---python/pip done---"
