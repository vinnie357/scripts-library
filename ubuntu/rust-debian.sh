#!/bin/bash
echo "---installing rust---"
if command -v cargo >/dev/null 2>&1; then
  # program_name exists, so run it
  cargo --version
else
  # program_name does not exist
  echo "Error: trying to install rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
  cargo --version
fi
echo "---rust done---"
