# Ubuntu Development Scripts

A comprehensive collection of **50+ installation scripts** for Ubuntu/Debian systems, providing automated setup for development tools, cloud platforms, containerization, and infrastructure components.

## 🚀 Quick Start

```bash
# Clone the repository
git clone <repo-url>
cd scripts-library/ubuntu

# Make scripts executable (optional - they're already executable)
chmod +x *.sh

# Run any script with sudo
sudo ./docker-ce-debian.sh
sudo ./kubectl-helm-debian.sh
sudo ./node-debian.sh
```

## 📋 Prerequisites

- **Operating System**: Ubuntu 18.04+ or Debian 10+
- **Permissions**: Root access (all scripts require `sudo`)
- **Network**: Reliable internet connection for package downloads
- **Disk Space**: At least 2GB available space
- **Architecture**: Most scripts support AMD64; some support ARM64

## 🛡️ Safety Features

- **Permission Checks**: All scripts verify root access before execution
- **Error Handling**: Scripts use `set -e` for immediate error termination
- **Non-Interactive Mode**: APT configured to avoid prompts (`DEBIAN_FRONTEND=noninteractive`)
- **Idempotent Design**: Safe to run multiple times (most scripts check existing installations)
- **Official Sources**: Scripts use official repositories and trusted download sources

---

## 📦 Complete Script Inventory

### 🐳 Container & Orchestration Tools

#### Docker Ecosystem
| Script | Description | Key Features |
|--------|-------------|--------------|
| `docker-ce-debian.sh` | Docker CE with Docker Compose | Latest Docker engine, CLI, compose plugin |
| `docker-debian.sh` | Standard Docker installation | Basic Docker runtime |
| `containerd-debian.sh` | Container runtime | Low-level container runtime |
| `runc-debian.sh` | Container runtime | OCI runtime specification |
| `nerd-ctl-debian.sh` | Containerd CLI | User-friendly containerd interface |

#### Kubernetes & Orchestration  
| Script | Description | Key Features |
|--------|-------------|--------------|
| `kubectl-helm-debian.sh` | Kubernetes CLI + Helm | Latest kubectl, Helm 3 package manager |
| `kubectx-kubens-debian.sh` | Kubernetes context tools | Fast context/namespace switching |
| `crictl-debian.sh` | Container Runtime Interface | Debug and manage container runtime |

#### Advanced Container Runtimes
| Script | Description | Key Features |
|--------|-------------|--------------|
| `kata-debian.sh` | Secure container runtime | VM-isolated containers |
| `firecracker-debian.sh` | MicroVM technology | Lightweight virtualization |
| `firecrackerImage-debian.sh` | Firecracker VM images | Pre-built VM images |
| `cloud-hypervisor-debian.sh` | Cloud hypervisor | Modern VMM for cloud workloads |

---

### ☁️ Cloud & Infrastructure Tools

#### Infrastructure as Code
| Script | Description | Version | Key Features |
|--------|-------------|---------|--------------|
| `terraform-debian.sh` | Infrastructure as Code | 0.14.0 (configurable) | HashiCorp Terraform |
| `terraform-docs-debian.sh` | Terraform documentation | Latest | Auto-generate docs |
| `pulumi-debian.sh` | Modern Infrastructure as Code | Latest | Multi-language IaC |

#### Cloud Platform CLIs
| Script | Description | Key Features |
|--------|-------------|--------------|
| `awscli-debian.sh` | AWS CLI v1 | Amazon Web Services CLI |
| `awscli2-debian.sh` | AWS CLI v2 | Latest AWS command line interface |
| `awsiam-debian.sh` | AWS IAM tools | Identity and Access Management |
| `azcli-debian.sh` | Azure CLI | Microsoft Azure command line |
| `gcloud-debian.sh` | Google Cloud CLI | Google Cloud Platform SDK |

#### Service Discovery & Orchestration  
| Script | Description | Default Version | Key Features |
|--------|-------------|-----------------|--------------|
| `consul-debian.sh` | Service mesh & discovery | 1.15.2-1 | HashiCorp Consul |
| `nomad-debian.sh` | Workload orchestration | Latest | HashiCorp Nomad |
| `waypoint-cli-debian.sh` | Application deployment | Latest | HashiCorp Waypoint |

---

### 🔧 Development Languages & Runtimes

#### Language Runtimes
| Script | Description | Key Features |
|--------|-------------|--------------|
| `node-debian.sh` | Node.js development | NVM, Node.js LTS, Yarn package manager |
| `go-debian.sh` | Go programming language | Latest Go compiler and tools |
| `python-debian.sh` | Python development | Python 3, pip, development headers |
| `rust-debian.sh` | Rust programming language | Rustc, Cargo, latest stable |

#### Development Utilities
| Script | Description | Key Features |
|--------|-------------|--------------|
| `jq-debian.sh` | JSON processing | Command-line JSON processor |
| `pre-commit-debian.sh` | Git pre-commit hooks | Code quality automation |

---

### 🌐 Networking & Security Tools

#### Web Servers & Load Balancers
| Script | Description | Key Features |
|--------|-------------|--------------|
| `nginx-debian.sh` | Web server | NGINX from Ubuntu repositories |
| `nginx-org.debian.sh` | Official NGINX | NGINX from official repositories |
| `traefik-debian.sh` | Load balancer | Cloud native edge router |
| `traefik-service-debian.sh` | Traefik as service | Systemd service configuration |

#### VPN & Networking
| Script | Description | Key Features |
|--------|-------------|--------------|
| `tailscale-debian.sh` | Mesh VPN | Zero-config VPN network |
| `wireguard-debian.sh` | VPN tunneling | Fast, modern VPN protocol |
| `websocat-debain.sh` | WebSocket utility | WebSocket client/server tool |

#### Cloud-Native Networking
| Script | Description | Key Features |
|--------|-------------|--------------|
| `cilium-cli-debian.sh` | eBPF-based networking | Cloud native networking, security |
| `hubble-cli-debian.sh` | Network observability | Cilium network observability |
| `cni-plugins-debian.sh` | Container Network Interface | Standard networking plugins |

#### Network Security
| Script | Description | Key Features |
|--------|-------------|--------------|
| `iptables-persistent-debian.sh` | Firewall persistence | Save/restore iptables rules |

---

### 🖥️ Virtualization & Emulation

#### Virtual Machine Management
| Script | Description | Key Features |
|--------|-------------|--------------|
| `qemu-debian.sh` | Machine emulation | Full system emulation |
| `vagrant-debian.sh` | Development environments | Portable development environments |

#### Specialized Virtualization
| Script | Description | Key Features |
|--------|-------------|--------------|
| `firecracker-debian.sh` | MicroVM technology | Fast boot times, security isolation |
| `firecrackerImage-debian.sh` | Firecracker images | Pre-built VM images for Firecracker |
| `cloud-hypervisor-debian.sh` | Cloud hypervisor | Modern VMM built in Rust |

---

### 🛠️ System & Base Tools

#### System Essentials
| Script | Description | Key Features |
|--------|-------------|--------------|
| `common-debian.sh` | Common dev packages | Comprehensive development toolkit |
| `base-debian.sh` | Base system packages | Essential system packages |
| `unzip-debian.sh` | Archive utilities | File extraction tools |
| `upgrade-debian.sh` | System updates | System package upgrades |

#### User Management
| Script | Description | Key Features |
|--------|-------------|--------------|
| `create-user.sh` | User account creation | Development user setup |
| `setup-user.sh` | User environment setup | Development environment configuration |

#### Browser & UI Tools
| Script | Description | Key Features |
|--------|-------------|--------------|
| `chrome_headless_debian.sh` | Headless browser | Chrome for testing/automation |

---

### 📚 Documentation & Automation

#### Automation Platforms
| Script | Description | Key Features |
|--------|-------------|--------------|
| `ansible-debian.sh` | Infrastructure automation | Configuration management |

#### Documentation Tools
| Script | Description | Key Features |
|--------|-------------|--------------|
| `sphinx-debian.sh` | Documentation generator | Python-based documentation |

#### Development Environments
| Script | Description | Key Features |
|--------|-------------|--------------|
| `coder-debian.sh` | Development workspaces | Cloud development environments |

---

### 🔍 Special Purpose Tools

#### Observability & Networking
| Script | Description | Key Features |
|--------|-------------|--------------|
| `vesctl-debian.sh` | Volterra CLI | Multi-cloud networking |
| `get-atc-debian.sh` | ATC utility | Air Traffic Control utility |
| `netmaker-debian.sh` | Network automation | WireGuard network automation |

#### Container Tools
| Script | Description | Key Features |
|--------|-------------|--------------|
| `govc-debian.sh` | vSphere CLI | VMware vSphere management |
| `golite-debian.sh` | Lightweight Go tools | Minimal Go utilities |

#### Web Services
| Script | Description | Key Features |
|--------|-------------|--------------|
| `unit-debian.sh` | NGINX Unit | Dynamic web application server |
| `packer-echo.sh` | Echo service | Simple HTTP echo server |

---

## 🚦 Usage Patterns

### Complete Development Environment
```bash
# Essential base setup
sudo ./common-debian.sh          # Development essentials
sudo ./base-debian.sh           # Base system packages

# Container development
sudo ./docker-ce-debian.sh      # Docker with compose
sudo ./kubectl-helm-debian.sh   # Kubernetes tools

# Language runtimes
sudo ./node-debian.sh           # Node.js development
sudo ./go-debian.sh             # Go development
sudo ./python-debian.sh         # Python development

# Infrastructure tools
sudo ./terraform-debian.sh      # Infrastructure as Code
sudo ./awscli2-debian.sh        # AWS CLI
```

### Cloud-Native Development Stack
```bash
# Container runtime and orchestration
sudo ./docker-ce-debian.sh
sudo ./kubectl-helm-debian.sh
sudo ./cilium-cli-debian.sh
sudo ./hubble-cli-debian.sh

# Service mesh and discovery
sudo ./consul-debian.sh
sudo ./nomad-debian.sh

# Infrastructure and cloud tools
sudo ./terraform-debian.sh
sudo ./pulumi-debian.sh
sudo ./awscli2-debian.sh
sudo ./gcloud-debian.sh
```

### Security & Networking Stack
```bash
# Network security
sudo ./wireguard-debian.sh
sudo ./tailscale-debian.sh
sudo ./iptables-persistent-debian.sh

# Load balancing and routing
sudo ./traefik-debian.sh
sudo ./nginx-org.debian.sh

# Observability
sudo ./cilium-cli-debian.sh
sudo ./hubble-cli-debian.sh
```

### Microservices Development
```bash
# Container tools
sudo ./docker-ce-debian.sh
sudo ./kubectl-helm-debian.sh
sudo ./nerd-ctl-debian.sh

# Service mesh
sudo ./consul-debian.sh

# Runtimes
sudo ./node-debian.sh
sudo ./go-debian.sh

# Utilities
sudo ./jq-debian.sh
sudo ./pre-commit-debian.sh
```

---

## 📊 Script Categories Summary

| Category | Count | Purpose |
|----------|-------|---------|
| **Container & Orchestration** | 9 scripts | Docker, Kubernetes, container runtimes |
| **Cloud & Infrastructure** | 11 scripts | IaC tools, cloud CLIs, service discovery |
| **Development Tools** | 6 scripts | Language runtimes, development utilities |
| **Networking & Security** | 9 scripts | Web servers, VPN, networking, security |
| **Virtualization & Emulation** | 5 scripts | VMs, emulation, specialized virtualization |
| **System & Utilities** | 7 scripts | Base packages, user management, system tools |
| **Documentation & Automation** | 3 scripts | Automation platforms, documentation |
| **Special Purpose** | 8 scripts | Observability, specialized tools |

**Total: 58 installation scripts**

---

## 🔧 Configuration & Customization

### Version Customization
Many scripts support version parameters:

```bash
# Terraform with specific version
sudo ./terraform-debian.sh 1.5.0

# Consul with specific version  
sudo ./consul-debian.sh 1.16.0-1

# Node.js with custom configuration
sudo ./node-debian.sh /usr/local/share/nvm lts/* myuser true
```

### Environment Variables
Some scripts respect environment variables:
```bash
export CONSUL_VERSION="1.16.0-1"
sudo ./consul-debian.sh

export NODE_VERSION="18.0.0" 
sudo ./node-debian.sh
```

---

## 🚨 Troubleshooting

### Common Issues

#### Permission Errors
```bash
# Error: Script must be run as root
# Solution: Use sudo
sudo ./script-name.sh
```

#### Network Issues
```bash
# Error: Could not download package
# Solution: Check internet connection and DNS
ping google.com
nslookup google.com
```

#### Repository Key Issues
```bash
# Error: GPG key verification failed
# Solution: Update package lists
sudo apt-get update
sudo apt-get install ca-certificates
```

#### Disk Space Issues
```bash
# Check available space
df -h
# Clean up if needed
sudo apt-get autoremove
sudo apt-get clean
```

### Verification Steps

#### Verify Installation Success
```bash
# Check Docker
docker --version
docker-compose --version

# Check Kubernetes tools
kubectl version --client
helm version

# Check language runtimes
node --version
go version
python3 --version
```

#### Check Service Status
```bash
# For services like Docker
sudo systemctl status docker

# For installed packages
dpkg -l | grep docker
```

---

## 🔄 Maintenance

### Keeping Tools Updated
```bash
# Update system packages
sudo apt-get update
sudo apt-get upgrade

# Update specific tools
sudo ./terraform-debian.sh   # Reinstall with latest version
sudo ./kubectl-helm-debian.sh  # Update Kubernetes tools
```

### Cleanup
```bash
# Remove unused packages
sudo apt-get autoremove

# Clean package cache
sudo apt-get clean

# Remove unused Docker resources
docker system prune -a
```

---

## 🏗️ Script Architecture

### Common Patterns
All scripts follow consistent patterns:

1. **Shebang**: `#!/bin/bash`
2. **Status Messages**: Echo statements for progress
3. **Error Handling**: `set -e` for immediate exit on errors
4. **Permission Check**: Verify root access
5. **Non-Interactive Mode**: Set `DEBIAN_FRONTEND=noninteractive`
6. **Prerequisites Check**: Verify required packages
7. **Installation**: Download and install target software
8. **Completion Message**: Confirm successful installation

### Script Safety Features
- **Root Permission Verification**: All scripts check for root access
- **Error Termination**: Scripts exit immediately on any error
- **Non-Interactive APT**: Prevents hanging on user prompts
- **Official Sources**: Use trusted repositories and download sources
- **Checksums**: Many scripts verify downloaded file integrity

---

## 📖 Script Documentation

### Individual Script Documentation
Most scripts include header comments with:
- Purpose and description
- Usage syntax and parameters  
- Links to official documentation
- Version information

### Microsoft VS Code Origins
Many scripts are derived from [Microsoft VS Code Dev Containers](https://github.com/microsoft/vscode-dev-containers/tree/master/script-library), providing:
- **Battle-tested reliability**: Used by thousands of developers
- **Consistent patterns**: Standardized installation approaches
- **Regular updates**: Maintained by Microsoft team
- **Cross-platform support**: Works across different Ubuntu/Debian versions

---

## 🚀 Advanced Usage

### Batch Installation
```bash
# Create custom installation script
#!/bin/bash
set -e

echo "Installing development stack..."

sudo ./common-debian.sh
sudo ./docker-ce-debian.sh  
sudo ./kubectl-helm-debian.sh
sudo ./node-debian.sh
sudo ./terraform-debian.sh
sudo ./awscli2-debian.sh

echo "Development stack installation complete!"
```

### Dockerfile Integration
```dockerfile
# Use in Dockerfile for development containers
FROM ubuntu:22.04

# Copy scripts
COPY ubuntu/*.sh /tmp/scripts/
RUN chmod +x /tmp/scripts/*.sh

# Install development tools
RUN /tmp/scripts/common-debian.sh
RUN /tmp/scripts/docker-debian.sh
RUN /tmp/scripts/node-debian.sh

# Cleanup
RUN rm -rf /tmp/scripts
```

### CI/CD Pipeline Usage
```yaml
# GitHub Actions example
- name: Setup Development Environment
  run: |
    chmod +x scripts-library/ubuntu/*.sh
    sudo scripts-library/ubuntu/common-debian.sh
    sudo scripts-library/ubuntu/docker-ce-debian.sh
    sudo scripts-library/ubuntu/kubectl-helm-debian.sh
```

---

## 🤝 Contributing

### Adding New Scripts
1. **Follow naming convention**: `toolname-debian.sh`
2. **Include safety checks**: Root permission verification
3. **Add error handling**: Use `set -e`
4. **Document parameters**: Include usage comments
5. **Test thoroughly**: Verify on clean Ubuntu/Debian systems
6. **Update documentation**: Add to this README

### Script Template
```bash
#!/bin/bash
echo "=====install TOOLNAME====="
set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

export DEBIAN_FRONTEND=noninteractive

# Installation logic here

echo "===== TOOLNAME done ====="
```

---

## 📄 License & Attribution

- **Scripts**: Individual scripts may have specific licenses (see script headers)
- **Microsoft Scripts**: Scripts derived from VS Code Dev Containers retain original MIT license
- **Custom Scripts**: Additional scripts follow repository license
- **Documentation**: Created for this repository

---

## 🔗 Related Resources

- [Microsoft VS Code Dev Containers](https://github.com/microsoft/vscode-dev-containers)
- [Ubuntu Official Documentation](https://ubuntu.com/server/docs)
- [Docker Official Installation Guide](https://docs.docker.com/engine/install/ubuntu/)
- [Kubernetes Installation Guide](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/)

---

**Ready to set up your development environment?** Choose the scripts that match your stack and run them with `sudo`. Each script is designed to be safe, reliable, and comprehensive.