#!/bin/bash
echo "===netmaker==="
#https://netmaker.readthedocs.io/en/develop/server-installation.html#nodocker
# broken on ubuntu 20.04:
#/usr/sbin/netmaker: /lib/x86_64-linux-gnu/libc.so.6: version `GLIBC_2.32' not found (required by /usr/sbin/netmaker)
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi
VERSION=${1:-"0.17.1"}
UI=${2:-"true"}

mkdir -p /etc/netmaker
wget -O /etc/netmaker/netmaker https://github.com/gravitl/netmaker/releases/download/v${VERSION}/netmaker
mv /etc/netmaker/netmaker /usr/sbin/netmaker
chmod +x /usr/sbin/netmaker

cat <<EOF > /etc/systemd/system/netmaker.service
[Unit]
Description=Netmaker Server
After=network.target

[Service]
Type=simple
Restart=on-failure

ExecStart=/usr/sbin/netmaker -c /etc/netmaker/netmaker.yml

[Install]
WantedBy=multi-user.target
EOF
if [ "$UI" = "true" ]; then
    mkdir -p /var/www/netmaker
    wget -O /tmp/netmaker-ui.zip https://github.com/gravitl/netmaker-ui/releases/download/v${VERSION}/netmaker-ui.zip
    unzip /tmp/netmaker-ui.zip -d /var/www/netmaker
    rm /tmp/netmaker-ui.zip
    # cat <<EOF > /var/www/netmaker/config.js
    #   window.REACT_APP_BACKEND='https://api.<YOUR_BASE_DOMAIN>'
    # EOF
fi
# cat <<EOF > /etc/netmaker/netmaker.yml
# server:
#   server: "broker.<YOUR_BASE_DOMAIN>"
#   apiport: "8081"
#   apiconn: "api.<YOUR_BASE_DOMAIN>:443"
#   masterkey: "<SECRET_KEY>"
#   mqhost: "127.0.0.1"
#   mqport: "8883"
#   mqadminpassword: "<CHOOSE_A_PASSWORD>"
# EOF

# systemctl daemon-reload
# systemctl restart netmaker
echo "=====finished netmaker====="
