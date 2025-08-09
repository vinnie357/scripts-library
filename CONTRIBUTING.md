# Contributing to Scripts Library

## Ubuntu Scripts

### Design Principles
Scripts must follow these principles:
- **Atomic design** - Install one tool only, avoid long complicated multi-tool installs
- **Composable** - Scripts should be combinable to create complex installations

### Pattern Requirements
Scripts must conform to the existing patterns in the repository:

#### Environment Variable Pattern
```bash
VERSION=${1:-${TOOLNAME_VERSION:-"default_version"}}
```

Examples:
- `VERSION=${1:-${VAGRANT_VERSION:-"2.4.0-1"}}`
- `VERSION=${1:-${CONSUL_VERSION:-"1.15.2-1"}}`
- `VERSION=${1:-${CNI_VERSION:-"1.2.0"}}`

#### Basic Safety Requirements
- Root permission check: `if [ "$(id -u)" -ne 0 ]; then ... fi`
- Error handling: `set -e`
- Non-interactive mode: `export DEBIAN_FRONTEND=noninteractive`

#### Usage
Scripts are designed for bare metal servers, devcontainers, virtual machines, and Packer images.

### Comments
Comments are acceptable and encouraged to explain script usage and functionality.

### Script Template
```bash
#!/bin/bash
echo "=====install TOOLNAME====="
VERSION=${1:-${TOOLNAME_VERSION:-"default_version"}}
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# Installation logic here

echo "===== TOOLNAME done ====="
```

## Claudio System

Follow existing agent architecture patterns. See existing commands and agents for reference.