#!/bin/bash
echo "---installing ansible---"

ansibleVersion=${1:-"latest"}
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

pip3 install "ansible==${ansibleVersion}"

echo "---ansible done---"
