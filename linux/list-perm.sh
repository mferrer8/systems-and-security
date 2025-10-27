#!/usr/bin/env bash
# list-perms.sh
# Lists files in the target directory showing owner, group, perms and size.
# Usage: ./list-perms.sh [target-directory]
# Example: ./list-perms.sh .   (lists current directory)

TARGET="${1:-.}"

# Header
printf "%-10s %-10s %-11s %-8s %s\n" "OWNER" "GROUP" "PERMISSIONS" "SIZE" "NAME"
printf "%-10s %-10s %-11s %-8s %s\n" "-----" "-----" "-----------" "----" "----"

# Iterate and print info (skipping . and ..)
find "$TARGET" -maxdepth 1 -mindepth 1 -printf '%u|%g|%M|%s|%P\n' \
  | sort -t'|' -k5 \
  | while IFS='|' read -r owner group perms size name; do
      printf "%-10s %-10s %-11s %-8s %s\n" "$owner" "$group" "$perms" "$size" "$name"
    done
