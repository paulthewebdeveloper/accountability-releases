#!/bin/sh -e
echo "Installing Accountability…"
FEED=https://raw.githubusercontent.com/paulthewebdeveloper/accountability-releases/main/version.json
URL=$(curl -fsSL "$FEED" | /usr/bin/python3 -c 'import json,sys; print(json.load(sys.stdin)["url"])')
TMP=$(mktemp -d)
curl -fsSL "$URL" -o "$TMP/app.tar.gz"
tar -xzf "$TMP/app.tar.gz" -C "$TMP"
osascript -e 'tell application "Accountability" to quit' >/dev/null 2>&1 || true
rm -rf /Applications/Accountability.app
ditto "$TMP/Accountability.app" /Applications/Accountability.app
xattr -dr com.apple.quarantine /Applications/Accountability.app 2>/dev/null || true
rm -rf "$TMP"
open /Applications/Accountability.app
echo "Done — Accountability is in /Applications."
