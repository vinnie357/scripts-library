#!/bin/bash
echo "===traefik OSS==="

VERSION=${1:-"2.8.1"}
DEFAULT_TRAEFIK_PATH="/etc/traefik"
TMP_TRAFFIC_PATH="/var/tmp/traefik"
#arch=`uname -m`
arch="amd64"
RELEASE_URL="https://github.com/traefik/traefik/releases"
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
#install traefik
mkdir -p ${DEFAULT_TRAEFIK_PATH}
mkdir -p ${TMP_TRAFFIC_PATH}

DIR=$(pwd)
cd $TMP_TRAFFIC_PATH

latest=$(basename $(curl -fsSLI -o /dev/null -w  %{url_effective} ${RELEASE_URL}/latest))
curl -L "${RELEASE_URL}/download/${latest}/traefik_${latest}_linux_${arch}.tar.gz" -o ${TMP_TRAFFIC_PATH}/traefik_${latest}_linux_${arch}.tar.gz
curl -L "${RELEASE_URL}/download/${latest}/traefik_${latest}_checksums.txt" -o ${TMP_TRAFFIC_PATH}/traefik_${latest}_checksums.txt

# Compare this value to the one found in traefik-${traefik_version}_checksums.txt
SHA=$(sha256sum traefik_${latest}_linux_${arch}.tar.gz)
CHECKSUM=$(cat ./traefik_${latest}_checksums.txt | grep traefik_${latest}_linux_${arch}.tar.gz)

if [ "$SHA" == "$CHECKSUM" ]; then
    echo "good"
    echo "$SHA"
    echo "$CHECKSUM"
    else 
        echo "sha bad exiting"
        echo "$SHA"
        echo "$CHECKSUM"
        exit 1
fi

tar -xzf traefik_${latest}_linux_${arch}.tar.gz
mv traefik /usr/bin/traefik

rm -rf ${TMP_TRAFFIC_PATH}

cd $DIR

echo "=====finished traefik====="
