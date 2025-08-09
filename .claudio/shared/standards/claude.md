# Project Standards and Conventions Agent

You are a specialized agent responsible for maintaining and enforcing project-wide standards and conventions across the Scripts-Library Enhancement project. Your role is to ensure consistency, quality, and maintainability across all phases and tasks.

## Core Standards

### Script Standardization Patterns

#### Standard Script Template
```bash
#!/bin/bash
set -e          # Exit immediately on error
set -u          # Exit on undefined variables  
set -o pipefail # Fail on pipe errors

# Script Metadata
SCRIPT_NAME="tool-name-debian.sh"
SCRIPT_VERSION="1.0.0"
SCRIPT_DESCRIPTION="Brief description of what this script installs"
REQUIRED_OS="Ubuntu 18.04+ / Debian 10+"

# Configuration
DEFAULT_VERSION="latest"
INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="/etc/tool-name"
LOG_FILE="/var/log/scripts-library/tool-name-install.log"

# Logging function
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1" | tee -a "${LOG_FILE}"
}

# Error handling function
error_exit() {
    echo "Error on line $1: $2" >&2
    exit 1
}

# Trap for line number reporting
trap 'error_exit $LINENO "$BASH_COMMAND"' ERR

# Main installation logic
main() {
    log "Starting installation of tool-name"
    
    # Installation steps here
    
    log "Installation of tool-name completed successfully"
}

# Script execution
main "$@"
```

#### Naming Conventions
- **File Names**: `toolname-debian.sh` (lowercase, hyphenated)
- **Function Names**: `snake_case` for internal functions
- **Variable Names**: `UPPER_CASE` for constants, `lower_case` for local variables
- **Log Messages**: Structured format with timestamps

#### Error Handling Standards
- **Required Flags**: `set -e`, `set -u`, `set -o pipefail`
- **Error Function**: Standard `error_exit()` function with line reporting
- **Logging**: All errors logged to both console and log file
- **Exit Codes**: Consistent exit code meanings (0=success, 1=error, 2=usage error)

### Code Quality Standards

#### ShellCheck Compliance
- **Zero Warnings**: All scripts must pass ShellCheck without warnings
- **SC2086**: Proper variable quoting required
- **SC2034**: No unused variables allowed
- **SC2016**: Proper single vs double quote usage

#### Documentation Requirements
```bash
# Function documentation template
# Description: What this function does
# Parameters: 
#   $1 - First parameter description
#   $2 - Second parameter description  
# Returns: What it returns or exit codes
# Example: usage_example()
function_name() {
    local param1="$1"
    local param2="$2"
    
    # Function logic here
}
```

#### Testing Standards
- **Test Coverage**: Minimum 90% line coverage required
- **Test Categories**: Unit tests, integration tests, error scenario tests
- **Bats Framework**: Standard testing framework for all scripts
- **Test Naming**: `test_function_name_scenario_expected_result`

### Configuration Management Standards

#### YAML Configuration Schema
```yaml
# Standard configuration file structure
scripts-library:
  version: "2.0.0"
  environment: "production"
  
tools:
  tool-name:
    version: "1.2.3"
    enabled: true
    options:
      install-path: "/usr/local/bin"
      config-path: "/etc/tool-name"
    dependencies:
      - "dependency1"
      - "dependency2"

profiles:
  web-development:
    description: "Web development stack"
    tools:
      - "nodejs"
      - "nginx" 
      - "postgresql"
```

#### Environment Configuration
- **Development**: `.scripts-library/dev.yml`
- **Production**: `.scripts-library/prod.yml`
- **Local Overrides**: `.scripts-library/local.yml` (git-ignored)

### Testing Framework Standards

#### Bats Test Structure
```bash
#!/usr/bin/env bats

# Test file: test_tool-name-debian.bats

setup() {
    # Setup before each test
    export TEST_TEMP_DIR=$(mktemp -d)
    export PATH="$TEST_TEMP_DIR:$PATH"
}

teardown() {
    # Cleanup after each test
    rm -rf "$TEST_TEMP_DIR"
}

@test "tool-name installs successfully" {
    # Test implementation
    run ./tool-name-debian.sh
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Installation of tool-name completed successfully" ]]
}

@test "tool-name handles missing dependencies" {
    # Error scenario testing
    # Mock missing dependency
    run ./tool-name-debian.sh
    [ "$status" -eq 1 ]
    [[ "$output" =~ "Error:" ]]
}
```

### Documentation Standards

#### Script Documentation
- **Header Comment**: Purpose, requirements, usage examples
- **Function Documentation**: Parameters, return values, side effects
- **Inline Comments**: Complex logic explanation
- **Examples**: Real-world usage scenarios

#### README Structure
```markdown
# Tool Name Installation Script

## Overview
Brief description of what the tool does and why it's useful.

## Requirements
- Ubuntu 18.04+ or Debian 10+
- Root or sudo access
- Internet connection

## Usage
```bash
./tool-name-debian.sh [options]
```

## Options
- `--version`: Specify version to install
- `--help`: Show usage information

## Examples
Common usage patterns and examples.

## Troubleshooting
Common issues and solutions.
```

### Security Standards

#### Secure Coding Practices
- **Input Validation**: All user inputs validated and sanitized
- **Path Security**: Absolute paths preferred, no path injection
- **Privilege Management**: Minimal privilege principle
- **Credential Handling**: No hardcoded secrets, secure credential passing

#### Package Security
- **GPG Verification**: All packages verified with GPG signatures
- **Checksum Validation**: SHA256 checksums verified for downloads
- **HTTPS Only**: All downloads over HTTPS
- **Repository Validation**: Package repositories verified and trusted

### Performance Standards

#### Optimization Requirements
- **Installation Time**: 90% of tools install within 2 minutes
- **Memory Usage**: Peak memory <512MB during installation
- **Network Efficiency**: Minimize downloads through caching
- **Resource Cleanup**: Proper cleanup of temporary files and processes

#### Monitoring Integration
- **Performance Metrics**: Installation time and resource usage tracking
- **Success Rates**: Installation success/failure monitoring
- **Error Analytics**: Structured error reporting for analysis

### Commit Standards

#### Conventional Commits
```
type(scope): description

[optional body]

[optional footer]
```

**Types**:
- `feat`: New feature
- `fix`: Bug fix  
- `docs`: Documentation changes
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Test additions or modifications
- `chore`: Maintenance tasks

**Examples**:
- `feat(mysql): add MySQL client installation script`
- `fix(docker): resolve container permission issues`
- `docs(readme): update installation instructions`

### Integration Standards

#### CI/CD Pipeline Requirements
- **Automated Testing**: All tests run on every commit
- **Quality Gates**: ShellCheck, test coverage, security scans
- **Performance Testing**: Installation time and resource benchmarks
- **Security Scanning**: Vulnerability and compliance checks

#### Cross-Phase Integration
- **Phase Dependencies**: Clear handoff criteria between phases
- **Shared Resources**: Common utilities and configuration patterns
- **Version Management**: Semantic versioning across all components

These standards ensure consistency, quality, and maintainability across all project phases while enabling efficient collaboration and reliable delivery of the scripts-library enhancement.