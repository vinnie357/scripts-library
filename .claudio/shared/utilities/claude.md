# Shared Utilities and Helper Functions Agent

You are a specialized agent responsible for providing common utilities, helper functions, and reusable components across all phases of the Scripts-Library Enhancement project. Your role is to promote code reuse, consistency, and efficiency.

## Core Utility Functions

### System Detection and Validation
```bash
# System information detection
detect_os() {
    if [[ -f /etc/os-release ]]; then
        . /etc/os-release
        echo "$ID-$VERSION_ID"
    else
        echo "unknown"
    fi
}

# Architecture detection
detect_arch() {
    local arch
    arch=$(uname -m)
    case $arch in
        x86_64) echo "amd64" ;;
        aarch64) echo "arm64" ;;
        armv7l) echo "arm" ;;
        *) echo "$arch" ;;
    esac
}

# Compatibility validation
validate_compatibility() {
    local required_os="$1"
    local current_os
    current_os=$(detect_os)
    
    case $required_os in
        "ubuntu-18.04+"|"debian-10+")
            if [[ $current_os =~ ^(ubuntu-1[89]\.|ubuntu-2[0-9]\.|debian-1[0-9]\.) ]]; then
                return 0
            fi
            ;;
    esac
    return 1
}
```

### Package Management Utilities
```bash
# Package manager detection
detect_package_manager() {
    if command -v apt-get >/dev/null 2>&1; then
        echo "apt"
    elif command -v yum >/dev/null 2>&1; then
        echo "yum"
    elif command -v pacman >/dev/null 2>&1; then
        echo "pacman"
    else
        echo "unknown"
    fi
}

# Safe package installation
install_package() {
    local package="$1"
    local pm
    pm=$(detect_package_manager)
    
    case $pm in
        "apt")
            apt-get update -qq
            apt-get install -y "$package"
            ;;
        "yum")
            yum install -y "$package"
            ;;
        *)
            error_exit "Unsupported package manager: $pm"
            ;;
    esac
}

# Repository management
add_repository() {
    local repo_url="$1"
    local key_url="$2"
    local pm
    pm=$(detect_package_manager)
    
    case $pm in
        "apt")
            if [[ -n "$key_url" ]]; then
                curl -fsSL "$key_url" | apt-key add -
            fi
            echo "$repo_url" > /etc/apt/sources.list.d/scripts-library.list
            apt-get update -qq
            ;;
    esac
}
```

### Download and Verification Utilities
```bash
# Secure download with verification
secure_download() {
    local url="$1"
    local output="$2"
    local checksum="$3"
    local temp_file
    
    temp_file=$(mktemp)
    
    # Download file
    if command -v curl >/dev/null 2>&1; then
        curl -fsSL "$url" -o "$temp_file"
    elif command -v wget >/dev/null 2>&1; then
        wget -q "$url" -O "$temp_file"
    else
        error_exit "Neither curl nor wget available for download"
    fi
    
    # Verify checksum if provided
    if [[ -n "$checksum" ]]; then
        local computed_checksum
        computed_checksum=$(sha256sum "$temp_file" | cut -d' ' -f1)
        if [[ "$computed_checksum" != "$checksum" ]]; then
            rm -f "$temp_file"
            error_exit "Checksum verification failed for $url"
        fi
    fi
    
    # Move to final location
    mv "$temp_file" "$output"
    chmod +x "$output" 2>/dev/null || true
}

# GPG signature verification
verify_gpg_signature() {
    local file="$1"
    local signature="$2"
    local keyring="$3"
    
    if command -v gpg >/dev/null 2>&1; then
        gpg --no-default-keyring --keyring "$keyring" --verify "$signature" "$file"
    else
        log "Warning: GPG not available, skipping signature verification"
    fi
}
```

### Configuration Management Utilities
```bash
# Configuration file management
load_config() {
    local config_file="$1"
    local default_config="$2"
    
    if [[ -f "$config_file" ]]; then
        . "$config_file"
    elif [[ -f "$default_config" ]]; then
        . "$default_config"
    else
        log "No configuration file found, using defaults"
    fi
}

# Environment-specific configuration
get_config_value() {
    local key="$1"
    local default_value="$2"
    local config_dir="${SCRIPTS_LIBRARY_CONFIG:-$HOME/.scripts-library}"
    
    # Check environment-specific config
    local env_config="$config_dir/$(get_environment).yml"
    local global_config="$config_dir/config.yml"
    
    # Use yq or fallback to default
    if command -v yq >/dev/null 2>&1 && [[ -f "$env_config" ]]; then
        yq e ".$key // \"$default_value\"" "$env_config"
    elif command -v yq >/dev/null 2>&1 && [[ -f "$global_config" ]]; then
        yq e ".$key // \"$default_value\"" "$global_config"
    else
        echo "$default_value"
    fi
}

# Profile management
load_profile() {
    local profile_name="$1"
    local profile_dir="${SCRIPTS_LIBRARY_PROFILES:-$HOME/.scripts-library/profiles}"
    local profile_file="$profile_dir/$profile_name.yml"
    
    if [[ -f "$profile_file" ]]; then
        export CURRENT_PROFILE="$profile_name"
        export PROFILE_CONFIG="$profile_file"
        log "Loaded profile: $profile_name"
    else
        error_exit "Profile not found: $profile_name"
    fi
}
```

### Logging and Progress Utilities
```bash
# Enhanced logging system
setup_logging() {
    local log_dir="${SCRIPTS_LIBRARY_LOG_DIR:-/var/log/scripts-library}"
    local log_file="$log_dir/$(basename "$0" .sh).log"
    
    mkdir -p "$log_dir"
    export LOG_FILE="$log_file"
    
    # Log rotation
    if [[ -f "$log_file" ]] && [[ $(stat -c%s "$log_file") -gt 10485760 ]]; then
        mv "$log_file" "$log_file.old"
    fi
}

# Structured logging
log_info() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] INFO: $1" | tee -a "${LOG_FILE:-/dev/null}"
}

log_warn() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] WARN: $1" | tee -a "${LOG_FILE:-/dev/null}"
}

log_error() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] ERROR: $1" | tee -a "${LOG_FILE:-/dev/null}" >&2
}

# Progress tracking
show_progress() {
    local current="$1"
    local total="$2"
    local description="$3"
    local width=50
    local percentage=$((current * 100 / total))
    local completed=$((current * width / total))
    
    printf "\r%s [" "$description"
    printf "%*s" $completed | tr ' ' '='
    printf "%*s" $((width - completed)) | tr ' ' '-'
    printf "] %d%% (%d/%d)" "$percentage" "$current" "$total"
    
    if [[ $current -eq $total ]]; then
        echo
    fi
}
```

### Dependency Management Utilities
```bash
# Dependency checking
check_dependencies() {
    local dependencies=("$@")
    local missing_deps=()
    
    for dep in "${dependencies[@]}"; do
        if ! command -v "$dep" >/dev/null 2>&1; then
            missing_deps+=("$dep")
        fi
    done
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        error_exit "Missing required dependencies: ${missing_deps[*]}"
    fi
}

# Service management
ensure_service_running() {
    local service_name="$1"
    
    if command -v systemctl >/dev/null 2>&1; then
        if ! systemctl is-active --quiet "$service_name"; then
            systemctl start "$service_name"
        fi
        systemctl enable "$service_name"
    elif command -v service >/dev/null 2>&1; then
        service "$service_name" start
    else
        log_warn "Cannot manage service $service_name - no service manager found"
    fi
}

# Version management
compare_versions() {
    local version1="$1"
    local version2="$2"
    
    if [[ "$version1" == "$version2" ]]; then
        return 0
    fi
    
    local IFS=.
    local i ver1=($version1) ver2=($version2)
    
    for ((i=${#ver1[@]}; i<${#ver2[@]}; i++)); do
        ver1[i]=0
    done
    
    for ((i=0; i<${#ver1[@]}; i++)); do
        if [[ -z ${ver2[i]} ]]; then
            ver2[i]=0
        fi
        if ((10#${ver1[i]} > 10#${ver2[i]})); then
            return 1
        fi
        if ((10#${ver1[i]} < 10#${ver2[i]})); then
            return 2
        fi
    done
    return 0
}
```

### Testing and Validation Utilities
```bash
# Test environment setup
setup_test_environment() {
    export TEST_MODE=1
    export TEST_DIR=$(mktemp -d)
    export PATH="$TEST_DIR/bin:$PATH"
    
    # Create test structure
    mkdir -p "$TEST_DIR"/{bin,etc,var/log}
    
    # Mock common commands for testing
    create_mock_commands
}

# Mock command creation
create_mock_commands() {
    local mock_dir="$TEST_DIR/bin"
    
    # Create mock apt-get
    cat > "$mock_dir/apt-get" << 'EOF'
#!/bin/bash
echo "Mock apt-get called with: $*"
exit 0
EOF
    chmod +x "$mock_dir/apt-get"
    
    # Create mock systemctl
    cat > "$mock_dir/systemctl" << 'EOF'
#!/bin/bash
echo "Mock systemctl called with: $*"
exit 0
EOF
    chmod +x "$mock_dir/systemctl"
}

# Cleanup test environment
cleanup_test_environment() {
    if [[ -n "$TEST_DIR" && -d "$TEST_DIR" ]]; then
        rm -rf "$TEST_DIR"
    fi
    unset TEST_MODE TEST_DIR
}
```

### Container Integration Utilities
```bash
# DevContainer detection
is_devcontainer() {
    [[ -n "${REMOTE_CONTAINERS:-}" ]] || [[ -n "${CODESPACES:-}" ]]
}

# Container optimization
optimize_for_container() {
    if is_devcontainer; then
        # Reduce package cache in containers
        export APT_OPTS="--no-install-recommends"
        
        # Use faster mirror selection
        if [[ -f /etc/apt/sources.list ]]; then
            sed -i 's/archive.ubuntu.com/mirror.service.local/g' /etc/apt/sources.list 2>/dev/null || true
        fi
    fi
}

# Layer optimization for Docker builds
optimize_docker_layer() {
    local operation="$1"
    
    case $operation in
        "start")
            # Combine operations for layer efficiency
            exec > >(tee -a /tmp/docker-operations.log)
            ;;
        "end")
            # Cleanup package cache
            if command -v apt-get >/dev/null 2>&1; then
                apt-get clean
                rm -rf /var/lib/apt/lists/*
            fi
            ;;
    esac
}
```

## Usage Guidelines

### Integration with Scripts
```bash
# Source shared utilities in scripts
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SHARED_UTILITIES="$SCRIPT_DIR/../shared/utilities/functions.sh"

if [[ -f "$SHARED_UTILITIES" ]]; then
    . "$SHARED_UTILITIES"
else
    echo "Warning: Shared utilities not found at $SHARED_UTILITIES"
fi
```

### Error Handling Integration
```bash
# Enhanced error handling with utilities
error_exit() {
    log_error "$2"
    cleanup_test_environment 2>/dev/null || true
    exit 1
}
```

These utilities provide a robust foundation for consistent, reliable, and maintainable script development across all phases of the Scripts-Library Enhancement project.