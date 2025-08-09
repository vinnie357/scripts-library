#!/bin/bash

# Claudio System Rollback Script
# Generated: 2025-08-08 13:53:07
# Target: /Users/vinnie/github/scripts-library/.claude
# Backup: /Users/vinnie/github/scripts-library/.claude/.upgrades/backups/backup-20250808-135307

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="/Users/vinnie/github/scripts-library/.claude"
BACKUP_DIR="$TARGET_DIR/.upgrades/backups/backup-20250808-135307"

echo "🔄 Starting Claudio System Rollback..."
echo "Target: $TARGET_DIR"
echo "Backup: $BACKUP_DIR"

# Verify backup exists
if [ ! -d "$BACKUP_DIR" ]; then
    echo "❌ Error: Backup directory not found: $BACKUP_DIR"
    exit 1
fi

echo "✅ Backup directory found"

# Create temporary backup of current state
TEMP_BACKUP="$TARGET_DIR/.upgrades/backups/pre-rollback-$(date +%Y%m%d-%H%M%S)"
echo "📦 Creating pre-rollback backup: $TEMP_BACKUP"
cp -r "$TARGET_DIR" "$TEMP_BACKUP" 2>/dev/null || true

# Remove new components added during upgrade
echo "🗑️  Removing new components..."
rm -f "$TARGET_DIR/agents/claudio/discovery-validator.md"
rm -f "$TARGET_DIR/agents/claudio/new-command-generator.md"
rm -f "$TARGET_DIR/agents/claudio/new-command-validator.md"
rm -f "$TARGET_DIR/agents/claudio/test-command-generator.md"
rm -f "$TARGET_DIR/agents/claudio/workflow-validator.md"
rm -rf "$TARGET_DIR/agents/claudio/prompts/new-command"
rm -rf "$TARGET_DIR/agents/claudio/prompts/test-generation"
rm -rf "$TARGET_DIR/agents/claudio/prompts/validation"
rm -f "$TARGET_DIR/commands/claudio/generate-test-commands.md"
rm -f "$TARGET_DIR/commands/claudio/new-command.md"

# Restore original files
echo "♻️  Restoring original files from backup..."
cp -r "$BACKUP_DIR/agents" "$TARGET_DIR/"
cp -r "$BACKUP_DIR/commands" "$TARGET_DIR/"

echo "✅ Rollback completed successfully!"
echo "📊 System Status:"
echo "   - Original components restored"
echo "   - New components removed"
echo "   - Pre-rollback backup saved: $TEMP_BACKUP"
echo ""
echo "🎯 Next Steps:"
echo "   - Verify system functionality"
echo "   - Check command availability"
echo "   - Review rollback logs if needed"

exit 0