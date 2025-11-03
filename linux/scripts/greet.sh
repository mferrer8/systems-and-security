#!/bin/bash
set -euo pipefail
#greet.sh - demonstrates argument handling in bash

if [ $# -q 0 ]; then
  echo "Usage: ./greet.sh <name1> [name2] ..."
  echo "ex: $@ Marc Andre Gene"
  exit 1
fi

# Capture all arguments as a list
names=("$@")

# Sort names alphabetically using 'sort'
sorted_names=$(printf "%s\n" "${names[@]}" | sort)

echo "=== Alphabetical Order ==="
while read -r name; do
    echo "Hello, $name!"
done <<< "$sorted_names"

# Reverse the order using 'tac'
reversed_names=$(printf "%s\n" "${names[@]}" | sort | tac)

echo
echo "=== Reverse Order ==="
while read -r name; do
    echo "Hello, $name!"
done <<< "$reversed_names"

echo 
echo "Number of names provided: $#"
echo "Now greeting each person..."

# Loop through all arguments
for NAME in "$@"; do
  echo "Hello, $NAME! Welcome to Bash scripting."
done
