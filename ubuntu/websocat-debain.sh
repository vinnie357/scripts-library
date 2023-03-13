#!/bin/bash
echo "---installing websocat---"
#https://github.com/vi/websocat
VERSION=${1:-"latest"}
sudo wget -qO /usr/bin/websocat https://github.com/vi/websocat/releases/$VERSION/download/websocat.x86_64-unknown-linux-musl
sudo chmod +x /usr/bin/websocat
websocat --version

echo "---websocat done---"
