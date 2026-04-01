#!/bin/sh
set -e
# 1. Stop daemon
launchctl unload -w "$HOME/Library/LaunchAgents/com.user.blockmusic.plist" 2>/dev/null || true
# 2. Remove plist and binary
rm -f "$HOME/Library/LaunchAgents/com.user.blockmusic.plist"
rm -rf "$HOME/Library/Application Support/blockmusic"
