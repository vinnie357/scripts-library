# Task 1.1: Fix Filename Typo Agent

You are a specialized agent focused on completing Task 1.1: Fix websocat-debain.sh filename typo. This is a critical foundational task that must be completed before any other standardization work.

## Task Overview
- **Priority**: HIGH (Critical Path)
- **Estimated Effort**: 2 hours
- **Dependencies**: None
- **Week**: 1-2 (Critical Issue Resolution)

## Task Description
Fix the filename typo in the scripts-library where `websocat-debain.sh` should be `websocat-debian.sh`. This typo affects script discoverability and follows a consistent naming pattern with other Debian scripts.

## Acceptance Criteria
- [ ] Locate websocat-debain.sh file in the ubuntu/ directory
- [ ] Rename file to websocat-debian.sh maintaining all file contents
- [ ] Verify script functionality remains unchanged after rename
- [ ] Update any references to the old filename in documentation or other scripts
- [ ] Commit change with clear commit message describing the fix

## Context Integration
- **Phase Context**: Reference `../claude.md` for overall Phase 1 coordination
- **Next Task**: This enables Task 1.2 (error handling) to proceed with clean codebase
- **Project Root**: `/Users/vinnie/github/scripts-library/`

## Implementation Guidelines

### Step 1: Locate and Examine File
1. Navigate to `/Users/vinnie/github/scripts-library/ubuntu/`
2. Confirm websocat-debain.sh exists and examine its contents
3. Verify it follows the same pattern as other debian scripts

### Step 2: Rename File
1. Use `git mv` to rename the file (preserves history)
2. Command: `git mv websocat-debain.sh websocat-debian.sh`
3. Verify the rename completed successfully

### Step 3: Check for References
1. Search entire project for references to old filename
2. Use: `grep -r "websocat-debain" .` 
3. Update any found references to use correct filename

### Step 4: Validate Script Functionality
1. Quick syntax check: `bash -n websocat-debian.sh`
2. Verify script header and structure match other debian scripts
3. Ensure no breaking changes introduced

### Step 5: Commit Change
1. Stage the change: `git add .`
2. Commit with message: "fix: correct websocat-debain.sh typo to websocat-debian.sh"
3. Follow conventional commit format for consistency

## Quality Requirements
- **File Integrity**: Script contents must remain unchanged
- **Git History**: Use git mv to preserve file history
- **Reference Updates**: All references to old filename must be updated
- **Conventional Commits**: Follow project commit message conventions
- **Testing**: Verify script syntax remains valid

## Success Validation
- [ ] File successfully renamed without content changes
- [ ] Git history preserved through git mv operation
- [ ] No remaining references to old filename in project
- [ ] Script passes basic syntax validation
- [ ] Change committed with appropriate message

## File Locations
- **Target File**: `/Users/vinnie/github/scripts-library/ubuntu/websocat-debain.sh`
- **Renamed To**: `/Users/vinnie/github/scripts-library/ubuntu/websocat-debian.sh`
- **Search Scope**: Entire `/Users/vinnie/github/scripts-library/` directory

## Risk Mitigation
- **Low Risk Task**: Simple filename correction with no logic changes
- **Backup Strategy**: Git provides automatic backup through version control
- **Validation**: Syntax checking ensures script remains functional

## Integration Notes
This fix is foundational for Phase 1 standardization work. The corrected filename enables:
- Consistent naming patterns across all Debian scripts
- Proper script discovery and documentation
- Clean baseline for subsequent standardization tasks

Upon completion, update the task status and proceed with systematic error handling implementation in Task 1.2.