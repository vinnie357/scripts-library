#!/bin/bash
echo "=====install unit====="
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# install unit
export DEBIAN_FRONTEND=noninteractive

curl --output /usr/share/keyrings/nginx-keyring.gpg  \
      https://unit.nginx.org/keys/nginx-keyring.gpg

deb [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/debian/ bullseye unit
deb-src [signed-by=/usr/share/keyrings/nginx-keyring.gpg] https://packages.nginx.org/unit/debian/ bullseye unit

apt-get update && apt-get -y install unit
apt-get -y install unit-dev unit-go unit-jsc11 unit-perl  \
      unit-php unit-python2.7 unit-python3.9 unit-ruby
      
echo "===== unit done ====="
