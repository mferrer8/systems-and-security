# Linux Permissions Reference

## ls -l
`ls -l` shows long listing of files:
- Example output: `-rwxr-xr-- 1 marc staff 1024 Jan  1 12:00 script.sh`
  - `-rwxr-xr--` → file type & permissions (owner/group/others)
  - `1` → number of hard links
  - `marc` → file owner
  - `staff` → file group
  - `1024` → size in bytes
  - `Jan 1 12:00` → timestamp
  - `script.sh` → filename

Permission bits:
- `r` = read, `w` = write, `x` = execute
- First char: `-` (file) or `d` (directory)
- Owner | Group | Others (three characters each)

## chmod (change mode)
Two common flavors:
- **Symbolic**: `chmod u+x file` (add execute for owner)
- **Numeric**: `chmod 750 file` (owner=7 rwx, group=5 r-x, others=0 ---)

Numeric values:
- `4` = read, `2` = write, `1` = execute
- Add them: `7` = 4+2+1 (rwx), `5` = 4+1 (r-x)

## chown (change owner)
- Change owner: `sudo chown marc file.txt`
- Change owner and group: `sudo chown marc:staff file.txt`
- Change group only: `sudo chown :staff file.txt`

**Security note:** avoid changing ownership of system files. Use `sudo` only when required.

## Example commands

# List files in current dir with permissions
ls -l

# List including hidden files and human-readable sizes
ls -alh

# Show permissions of a specific file
ls -l path/to/file.txt

# Change permissions (symbolic)
chmod u+x script.sh          # give owner execute
chmod g-w somefile.txt       # remove write from group

# Change permissions (numeric)
chmod 644 document.txt       # owner rw, group r, others r
chmod 750 script.sh          # owner rwx, group r-x, others none

# Change owner and group
sudo chown marc file.txt
sudo chown marc:staff file.txt

# Check effective permissions as a different user (useful in lab)
sudo -u otheruser ls -l somefile
