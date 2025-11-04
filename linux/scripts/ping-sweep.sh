#!/bin/bash
# Simple ping sweep (variable-based)
# Save as linux/scripts/ping_sweep.sh
# Usage: ./ping_sweep.sh

sites="www.google.com www.yahoo.com www.bing.com"

echo "Starting ping sweep..."
echo "----------------------"

for site in $sites; do
  printf "Checking %s... " "$site"
  # send 2 pings, wait up to 2 seconds for each reply; silence ping output
  if ping -c 2 -W 2 "$site" > /dev/null 2>&1; then
    echo "reachable"
  else
    echo "unreachable"
  fi
done

echo
echo "All checks complete."
