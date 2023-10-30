#!/bin/bash
echo "---installing traefik service---"
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# make traefik user
adduser --system --no-create-home --group traefik
# make traefik directories
traefik_dir="/etc/traefik"
traefik_log_dir="/var/log/traefik"
traefik_ssl_dir="/etc/ssl/traefik"
mkdir -p $traefik_dir $traefik_log_dir $traefik_ssl_dir
# set permissions
chown -R traefik:traefik $traefik_dir $traefik_log_dir $traefik_ssl_dir
# write traefik service
cat << EOF > /etc/systemd/system/traefik.service
#https://github.com/wych42/ansible-role-traefik/blob/master/templates/traefik.service.j2
[Unit]
Description=Traefik
Documentation=https://docs.traefik.io
After=network-online.target
Wants=network-online.target
AssertFileIsExecutable=/usr/bin/traefik
AssertPathExists=/etc/traefik/traefik.toml

[Service]
# Run traefik as its own user (create new user with: useradd -r -s /bin/false -U -M traefik)
User=traefik
Group=traefik
AmbientCapabilities=CAP_NET_BIND_SERVICE
#EnvironmentFile=/path/to/traefik.env
WorkingDirectory=/etc/traefik

# configure service behavior
Type=notify
ExecStart=/usr/bin/traefik --configfile=traefik.toml --log.filePath=/var/log/traefik/traefik.log
Restart=always
RestartSec=1
WatchdogSec=1s
LimitNOFILE=65536

# lock down system access
# prohibit any operating system and configuration modification
# ProtectSystem=strict
# create separate, new (and empty) /tmp and /var/tmp filesystems
# PrivateTmp=true
# make /home directories inaccessible
 ProtectHome=true
# turns off access to physical devices (/dev/...)
# PrivateDevices=true
# make kernel settings (procfs and sysfs) read-only
 ProtectKernelTunables=true
# make cgroups /sys/fs/cgroup read-only
ProtectControlGroups=true
# allow writing of acme.json
ReadWritePaths=/etc/ssl/traefik/
# allow writing of traefik logs
ReadWritePaths=/var/log/traefik/

[Install]
WantedBy=multi-user.target

EOF

echo "---traefik service done---"
