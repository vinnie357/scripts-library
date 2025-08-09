# Scripts Library

A curated collection of **50+ installation scripts** for Ubuntu/Debian systems, providing automated setup for development tools, cloud platforms, containerization, and infrastructure components.

## 🚀 Quick Start

```bash
# Clone the repository
git clone <this-repo>
cd scripts-library/ubuntu

# Run any script with sudo
sudo ./docker-ce-debian.sh
sudo ./kubectl-helm-debian.sh
sudo ./node-debian.sh
```

## 📦 Ubuntu Installation Scripts

The `ubuntu/` directory contains installation scripts for:

- **Container & Orchestration**: Docker, Kubernetes, container runtimes
- **Cloud & Infrastructure**: Terraform, AWS CLI, Azure CLI, Google Cloud CLI
- **Development Tools**: Node.js, Go, Python, Rust, development utilities
- **Networking & Security**: NGINX, Traefik, VPN tools, security utilities
- **Virtualization**: QEMU, Vagrant, specialized container runtimes
- **System Tools**: Base packages, user management, system utilities

**[📖 View Complete Script Documentation →](ubuntu/README.md)**

## 🔧 Script Features

### Atomic Design
- **One tool per script** - Each script installs a single tool or service
- **Composable** - Combine multiple scripts for complex setups
- **Modular** - Pick and choose exactly what you need

### Environment Variable Support
Scripts support version pinning via environment variables:
```bash
# Using environment variables
export CONSUL_VERSION="1.16.0-1"
sudo ./consul-debian.sh

# Using positional arguments
sudo ./terraform-debian.sh 1.5.0
```

### Multi-Environment Design
Scripts are designed for:
- **Bare metal servers** - Direct installation on physical hardware
- **DevContainers** - VS Code development containers  
- **Virtual machines** - VM provisioning and setup
- **Packer images** - Automated image building

## 🏗️ Repository Structure

```
scripts-library/
├── README.md              # This overview
├── CONTRIBUTING.md        # Contribution guidelines
├── ubuntu/                # 50+ Ubuntu installation scripts
│   ├── README.md         # Complete script documentation  
│   └── *.sh              # Installation scripts
└── claudio/              # Project analysis system
    └── README.md         # Claudio system documentation
```

## 🚦 Getting Started

1. **Clone the repository**: `git clone <this-repo>`
2. **Navigate to ubuntu scripts**: `cd scripts-library/ubuntu`
3. **Run desired installation scripts**: `sudo ./script-name.sh`
4. **[Optional] Set versions**: `export TOOLNAME_VERSION="x.y.z"`

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines. Scripts should follow existing patterns with environment variable support.

## 📄 License

Individual scripts may have specific licenses (see script headers). Most scripts are derived from Microsoft VS Code Dev Container scripts under MIT license.

---

*Documentation and tools built with Claudio and Claude*