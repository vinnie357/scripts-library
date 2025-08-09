# Task 1.2: Add Error Handling Agent

You are a specialized agent focused on completing Task 1.2: Add proper error handling to 12 scripts missing it. This is a critical safety and reliability task that establishes consistent error handling patterns across all scripts.

## Task Overview
- **Priority**: HIGH (Critical Path)
- **Estimated Effort**: 1 day
- **Dependencies**: None (can run parallel with Task 1.1)
- **Week**: 1-2 (Critical Issue Resolution)

## Task Description
Identify and add proper error handling (`set -e` and related patterns) to the 12 scripts that currently lack consistent error handling. This ensures scripts fail fast on errors and provide reliable execution behavior.

## Acceptance Criteria
- [ ] Identify all 12 scripts lacking proper error handling
- [ ] Add `set -e` (exit on error) to each script
- [ ] Add `set -u` (exit on undefined variables) where appropriate
- [ ] Add `set -o pipefail` (fail on pipe errors) where appropriate
- [ ] Implement consistent error logging patterns
- [ ] Test each modified script for proper error handling behavior
- [ ] Document error handling additions in commit messages

## Context Integration
- **Phase Context**: Reference `../claude.md` for Phase 1 standardization objectives
- **Parallel Task**: Can work alongside Task 1.1 (filename fix)
- **Feeds Into**: Task 1.4 (logging) and Task 1.5 (template creation)

## Implementation Guidelines

### Step 1: Identify Scripts Missing Error Handling
1. Audit all 59 scripts in `/Users/vinnie/github/scripts-library/ubuntu/`
2. Look for scripts missing `set -e` at the top
3. Check for inconsistent error handling patterns
4. Document findings with script names and current state

### Step 2: Establish Error Handling Standards
Based on bash best practices, implement:
```bash
#!/bin/bash
set -e          # Exit immediately on error
set -u          # Exit on undefined variables
set -o pipefail # Fail on pipe errors
```

### Step 3: Add Error Handling to Each Script
For each of the 12 scripts:
1. Add the error handling flags after shebang line
2. Preserve existing functionality and logic
3. Add error context where beneficial
4. Test script behavior with induced errors

### Step 4: Error Logging Enhancement
Where beneficial, add error logging:
```bash
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# Usage: command || error_exit "Description of what failed"
```

### Step 5: Validation Testing
1. Test each modified script with valid inputs
2. Test error scenarios to ensure proper failure behavior
3. Verify no regression in existing functionality
4. Document any behavior changes

## Quality Requirements
- **Consistency**: All scripts use same error handling pattern
- **Safety**: Scripts must fail safely on errors
- **Backward Compatibility**: No breaking changes to existing functionality
- **Testing**: Each script validated for proper error behavior
- **Documentation**: Clear commit messages explaining changes

## Scripts Currently Missing Error Handling
Based on PRD analysis indicating 12 scripts lack proper error handling. Need to identify these through audit:

1. Examine each script for presence of `set -e`
2. Check for consistent error handling patterns
3. Identify scripts with potential error handling gaps
4. Prioritize critical scripts (docker, kubernetes, core tools)

## Error Handling Patterns to Implement

### Basic Pattern (Minimum Required)
```bash
#!/bin/bash
set -e
set -u
set -o pipefail
```

### Enhanced Pattern (For Complex Scripts)
```bash
#!/bin/bash
set -e
set -u  
set -o pipefail

# Error handling function
error_exit() {
    echo "Error on line $1: $2" >&2
    exit 1
}

# Trap for line number reporting
trap 'error_exit $LINENO "$BASH_COMMAND"' ERR
```

### Script-Specific Considerations
- **Network-dependent scripts**: Handle network failures gracefully
- **Package managers**: Handle package availability and conflicts
- **File operations**: Check file permissions and disk space
- **Service management**: Handle service start/stop failures

## Success Validation
- [ ] All 12 scripts identified and documented
- [ ] Error handling added consistently across all scripts
- [ ] Scripts pass syntax validation: `bash -n script.sh`
- [ ] Error scenarios trigger proper failure behavior
- [ ] No regression in normal operation
- [ ] Commits follow conventional commit format

## Testing Strategy
1. **Syntax Testing**: `bash -n` for each modified script
2. **Error Injection**: Introduce errors to test failure behavior
3. **Integration Testing**: Run scripts in test environment
4. **Regression Testing**: Verify existing functionality unchanged

## Risk Mitigation
- **Medium Risk**: Error handling changes could alter script behavior
- **Mitigation**: Thorough testing of each modified script
- **Rollback Plan**: Git provides easy rollback capability
- **Gradual Implementation**: Test each script individually before batch commit

## Integration Notes
This task establishes critical safety patterns for:
- Task 1.4: Consistent logging implementation
- Task 1.5: Script template with standard error handling
- Phase 2: Reliable foundation for new tool additions

The error handling patterns established here will be included in the standard template created in Task 1.5, ensuring all future scripts inherit consistent error handling behavior.

Upon completion, all scripts will have reliable error handling, reducing support burden and improving user experience through predictable failure behavior.