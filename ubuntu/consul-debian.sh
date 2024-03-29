#!/bin/bash
echo "=====install consul====="
#apt-cache madison consul
VERSION=${1:-${CONSUL_VERSION:-"1.15.2-1"}}
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# install consul
export DEBIAN_FRONTEND=noninteractive
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && sudo apt-get -y install consul=${VERSION}
echo "===== consul done ====="
