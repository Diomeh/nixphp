#!/usr/bin/env bash

echo "Starting local dnsmasq on port 5353 (without sudo)..."

# Kill any existing dnsmasq instances (only ones started by this user)
pkill -f "dnsmasq.*--port=5353" || true

# Generate a temporary dnsmasq config
DNSMASQ_CONF=$(mktemp)

# Find all directories in the current directory (excluding hidden ones like .git and .direnv)
for dir in $(find . -maxdepth 1 -type d -not -path "./.*" -not -path "./.direnv" -exec basename {} \;); do
    echo "address=/${dir}.test/127.0.0.1" >>"$DNSMASQ_CONF"
done

# Start dnsmasq on port 5353 as a normal user
dnsmasq --no-resolv --keep-in-foreground --port=5353 --conf-file="$DNSMASQ_CONF" &

echo "dnsmasq is running."
