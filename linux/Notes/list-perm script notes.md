## Script Overview

This script lists files in a given directory, showing their:

  Owner

  Group

  Permissions

  Size

  Filename

It uses basic Linux commands (find, printf, sort, while, etc.) and can run on almost any system.
---
---

## The shebang line.
```
#!/usr/bin/env bash
```

Tells the system to use the bash interpreter located wherever your environment has it (/usr/bin/env finds it dynamically).

This ensures portability — it’ll work on systems where Bash isn’t always in /bin/bash.

## comments
```
# list-perms.sh
# Lists files in the target directory showing owner, group, perms and size.
# Usage: ./list-perms.sh [target-directory]
# Example: ./list-perms.sh .   (lists current directory)
```

These are comments (#) — ignored by Bash.

Provide context and usage help for future you (or anyone else reading your repo).

```
TARGET="${1:-.}"
```
## Breakdown:

$1 = the first argument passed to the script (e.g. if you run ./list-perms.sh /home, then $1 = /home).

${1:-.} means:

“Use $1 if it’s set, otherwise use . (current directory).”

This is called parameter expansion in Bash.

So:

./list-perms.sh /etc → TARGET=/etc

./list-perms.sh → TARGET=.

--- In short: It gives your script a default argument if none is provided.

# Header
```
printf "%-10s %-10s %-11s %-8s %s\n" "OWNER" "GROUP" "PERMISSIONS" "SIZE" "NAME"
printf "%-10s %-10s %-11s %-8s %s\n" "-----" "-----" "-----------" "----" "----"
```
🔍 Breakdown:

printf = prints formatted text (like in C).

%-10s means:

Print a string (s) in a 10-character wide field.

The - left-aligns the text.

So this creates columns that line up neatly:

OWNER | GROUP | PERMISSIONS | SIZE | NAME

The second line just prints separators under the header.

```
find "$TARGET" -maxdepth 1 -mindepth 1 -printf '%u|%g|%M|%s|%P\n' \
```
## Breakdown:

find = lists files/directories recursively.

"$TARGET" = the folder we want to inspect.

-maxdepth 1 → only go one level deep (don’t list subfolders recursively).

-mindepth 1 → skip the directory itself (the “.” entry).

-printf = custom output format:

%u → file owner

%g → file group

%M → file permissions (e.g. -rw-r--r--)

%s → file size in bytes

%P → relative path (filename only, no leading ./)

\n → newline at the end

| characters separate each field (we’ll split on them later).

So this line produces output like:
```
marc|staff|-rw-r--r--|2048|notes.txt
root|root|drwxr-xr-x|4096|logs
```
```
  | sort -t'|' -k5 \
```

The pipe (|) sends the output of find into sort.

-t'|' → use the pipe character as a field delimiter.

-k5 → sort by the 5th field, which in our format is the filename.

This ensures the results are alphabetized.

```
  | while IFS='|' read -r owner group perms size name; do
```
## Breakdown:

The pipe sends sorted lines into a while loop.

IFS='|' sets the Internal Field Separator to |, meaning each | splits variables.

read -r owner group perms size name reads one line at a time and assigns:

$owner, $group, $perms, $size, $name

-r prevents backslash escapes from being interpreted.

      printf "%-10s %-10s %-11s %-8s %s\n" "$owner" "$group" "$perms" "$size" "$name"


Prints each variable in the same column format as before.

Each line of output looks like this:

OWNER      GROUP      PERMISSIONS SIZE     NAME
marc       staff      -rw-r--r--  2048     notes.txt
root       root       drwxr-xr-x  4096     logs

    done


Ends the while loop.

-How It All Works Together

Here’s the flow of the entire script:

Set a target directory (argument or .).

Print a formatted header.

Use find to collect file metadata in a consistent format.

Sort the output alphabetically.

Loop through each line, split the fields, and print them neatly.

Done — clean, readable output for file permissions.

## Example Run
```
$ ./list-perms.sh /home/marc/test
OWNER      GROUP      PERMISSIONS SIZE     NAME
-----      -----      ----------- ----     ----
marc       staff      -rw-r--r--  2048     notes.txt
marc       staff      drwxr-xr-x  4096     scripts
```
