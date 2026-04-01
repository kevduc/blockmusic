#!/bin/sh
set -e

BIN="$HOME/Library/Application Support/blockmusic/blockmusic"
SHA="f74df1bcc93170660a981c845bf07ad8ca494ff2b5d2064d07824dea8764841f"
PLIST="$HOME/Library/LaunchAgents/com.user.blockmusic.plist"

# 1. Download binary and verify integrity
mkdir -p "$(dirname "$BIN")"
curl -sfSL "https://github.com/kevduc/blockmusic/releases/latest/download/blockmusic" -o "$BIN.tmp"
echo "$SHA  $BIN.tmp" | shasum -a 256 -c || {
    rm -f "$BIN.tmp";
    echo "SHA-256 mismatch";
    exit 1;
}
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
