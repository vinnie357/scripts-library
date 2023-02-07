#!/bin/bash
echo "===nginx-org OSS==="

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive
# packages
apt update && apt install -y curl gnupg2 ca-certificates lsb-release ubuntu-keyring

# gpg keys
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null

gpg --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg

# stable
# echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
# http://nginx.org/packages/ubuntu `lsb_release -cs` nginx" \
#     | tee /etc/apt/sources.list.d/nginx.list
# mainline
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

# pinning to nginx-org
echo -e "Package: *\nPin: origin nginx.org\nPin: release o=nginx\nPin-Priority: 900\n" \
    | tee /etc/apt/preferences.d/99nginx

apt update
apt install -y nginx

echo "=====finished nginx-org====="
