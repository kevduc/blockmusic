#!/bin/sh
set -e

BIN="$HOME/Library/Application Support/blockmusic/blockmusic"
PLIST="$HOME/Library/LaunchAgents/com.user.blockmusic.plist"

# 1. Build from source
./build.sh
mkdir -p "$(dirname "$BIN")"
cp build/blockmusic "$BIN.tmp"
chmod +x "$BIN.tmp"

# 2. Stop existing daemon, replace binary
launchctl unload -w "$PLIST" 2>/dev/null || true
mv "$BIN.tmp" "$BIN"

# 3. Register as background daemon (runs at login, restarts if killed)
cat <<EOF > "$PLIST"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>            <string>com.user.blockmusic</string>
    <key>ProgramArguments</key> <array><string>$BIN</string></array>
    <key>RunAtLoad</key>        <true/>
    <key>KeepAlive</key>        <true/>
</dict>
</plist>
EOF

# 4. Start daemon now
launchctl load -w "$PLIST"
echo "blockmusic installed and running"
