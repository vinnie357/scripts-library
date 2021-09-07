#!/usr/bin/env bash
#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/microsoft/vscode-dev-containers/blob/master/script-library/docs/go.md
#
# Syntax: ./go-debian.sh [Go version] [GOROOT] [GOPATH] [non-root user] [Add GOPATH, GOROOT to rc files flag] [Install tools flag]

TARGET_GO_VERSION=${1:-"latest"}
TARGET_GOROOT=${2:-"/usr/local/go"}
TARGET_GOPATH=${3:-"/go"}
USERNAME=${4:-"automatic"}
UPDATE_RC=${5:-"true"}
INSTALL_GO_TOOLS=${6:-"false"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Determine the appropriate non-root user
if [ "${USERNAME}" = "auto" ] || [ "${USERNAME}" = "automatic" ]; then
    USERNAME=""
    POSSIBLE_USERS=("vscode" "node" "codespace" "f5-devops" "$(awk -v val=1000 -F ":" '$3==val{print $1}' /etc/passwd)")
    for CURRENT_USER in ${POSSIBLE_USERS[@]}; do
        if id -u ${CURRENT_USER} > /dev/null 2>&1; then
            USERNAME=${CURRENT_USER}
            break
        fi
    done
    if [ "${USERNAME}" = "" ]; then
        USERNAME=root
    fi
elif [ "${USERNAME}" = "none" ] || ! id -u ${USERNAME} > /dev/null 2>&1; then
    USERNAME=root
fi

function updaterc() {
    if [ "${UPDATE_RC}" = "true" ]; then
        echo "Updating /etc/bash.bashrc and /etc/zsh/zshrc..."
        echo -e "$1" | tee -a /etc/bash.bashrc >> /etc/zsh/zshrc
    fi
}

export DEBIAN_FRONTEND=noninteractive

# Get latest version number if latest is specified
if [ "${TARGET_GO_VERSION}" = "latest" ] ||  [ "${TARGET_GO_VERSION}" = "current" ] ||  [ "${TARGET_GO_VERSION}" = "lts" ]; then
    TARGET_GO_VERSION=$(curl -sSL "https://golang.org/VERSION?m=text" | sed -n '/^go/s///p' )
fi

# Install Go
GO_INSTALL_SCRIPT="$(cat <<EOF
    set -e
    echo "Downloading Go ${TARGET_GO_VERSION}..."
    curl -sSL -o /tmp/go.tar.gz "https://golang.org/dl/go${TARGET_GO_VERSION}.linux-amd64.tar.gz"
    echo "Extracting Go ${TARGET_GO_VERSION}..."
    #tar -xzf /tmp/go.tar.gz -C "${TARGET_GOROOT}" --strip-components=1
    tar -xvf /tmp/go.tar.gz -C "${TARGET_GOROOT}" go/bin/go --strip-components=1
    rm -f /tmp/go.tar.gz
EOF
)"
if [ "${TARGET_GO_VERSION}" != "none" ] && ! type go > /dev/null 2>&1; then
    mkdir -p "${TARGET_GOROOT}" "${TARGET_GOPATH}"
    chown -R ${USERNAME} "${TARGET_GOROOT}" "${TARGET_GOPATH}"
    su ${USERNAME} -c "${GO_INSTALL_SCRIPT}"
else
    echo "Go already installed. Skipping."
fi

# Add GOPATH variable and bin directory into PATH in bashrc/zshrc files (unless disabled)
updaterc "export GOPATH=\"${TARGET_GOPATH}\"\nexport GOROOT=\"${TARGET_GOROOT}\"\nexport PATH=\"\${GOROOT}/bin:\${GOPATH}/bin:\${PATH}\""
echo "Done!"
