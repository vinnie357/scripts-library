# Ubuntu Scripts TODO

## Individual Component Scripts Needed

The following bundled scripts should have individual component scripts created to provide atomic installation options while keeping the bundled versions for convenience.

### Kubernetes Toolset

#### kubectl-helm-debian.sh
**Current**: Installs kubectl + Helm together  
**Keep existing**: `kubectl-helm-debian.sh` (kubernetes toolset)  
**Create individual scripts**:
- `kubectl-debian.sh` - Kubernetes CLI only
- `helm-debian.sh` - Helm package manager only

**Benefits**: Users can install just kubectl for basic Kubernetes operations or just Helm for package management.

#### kubectx-kubens-debian.sh
**Current**: Installs kubectx + kubens together  
**Keep existing**: `kubectx-kubens-debian.sh` (kubernetes-cli-toolset)  
**Create individual scripts**:
- `kubectx-debian.sh` - Kubernetes context switching only
- `kubens-debian.sh` - Kubernetes namespace switching only

**Benefits**: Users can install just the context switcher or just the namespace switcher based on their needs.

## Implementation Notes

### Pattern to Follow
1. **Keep bundled scripts unchanged** - Maintain backward compatibility
2. **Create focused individual scripts** - Extract single-tool installations
3. **Follow existing patterns** - Use environment variables: `KUBECTL_VERSION`, `HELM_VERSION`, etc.
4. **Update documentation** - Note both bundled and individual options in README

### Environment Variables
- `KUBECTL_VERSION` for kubectl-debian.sh
- `HELM_VERSION` for helm-debian.sh  
- `KUBECTX_VERSION` for kubectx-debian.sh
- `KUBENS_VERSION` for kubens-debian.sh

### Script Safety
All individual scripts should follow existing patterns:
- Root permission checks
- Error handling (`set -e`)
- Non-interactive mode
- Prerequisites verification

## Priority
**Medium** - These bundled scripts work fine as-is, but individual components would provide better flexibility for atomic installations.