#!/bin/bash
echo "=====install nomad====="
#apt-cache madison nomad
VERSION=${1:-${NOMAD_VERSION:-"1.5.2-1"}}
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# install nomad
export DEBIAN_FRONTEND=noninteractive
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && sudo apt-get -y install nomad=${VERSION}
echo "===== nomad done ====="
