
# OverTheWire: Bandit – Level 05–06

**Date:** 10/25/2025
**Goal:** The password for the next level is stored in a file somewhere under the inhere directory and has all of the following properties:

human-readable
1033 bytes in size
not executable

---

## Commands used:
```bash
bandit5@bandit:~$ find ./inhere/ -type f -size 1033c
./inhere/maybehere07/.file2
bandit5@bandit:~$ cat ./inhere/maybehere007/.file2 #only one file returned fitting the byte size requirement
cat: ./inhere/maybehere007/.file2: No such file or directory
#misspelled the maybehere* directory
bandit5@bandit:~$ cat ./inhere/maybehere07/.file2
<password>
#Verified size and permissions with ls -ll; permission bits -rw-r----- confirm the file is not executable.
bandit5@bandit:~$ ls -ll ./inhere/maybehere07/.file2
-rw-r----- 1 root bandit5 1033 Oct 14 09:26 ./inhere/maybehere07/.file2
bandit5@bandit:~$
````

---

## Issue Encountered

Had a few syntax errors and path misspellings that initially prevented finding and reading the correct file.
Specifically:

* Missed the `-` before `size` in the `find` command.
* Mistyped the directory as `maybehere007` instead of `maybehere07`.

---

## About the Commands

`find ./inhere/ -type f -size 1033c` – Searches the `inhere` directory for files (`-type f`) exactly **1033 bytes** in size (`-size 1033c`).
`cat ./inhere/maybehere07/.file2` – Displays the contents of the specified file.
`ls -ll ./inhere/maybehere07/.file2` – Lists detailed file information, including permissions, ownership, and size.
`wc -c ./inhere/maybehere07/.file2` – (Optional) Counts the number of bytes in the file to verify size.
`file ./inhere/maybehere07/.file2` – (Optional) Identifies the file type based on content rather than extension.

---

## Key Takeaways

* Always include the hyphen before `find` options like `-size` to avoid syntax errors.
* Double-check directory and filename spelling when you get “No such file or directory.”
* Use `ls -ll` to confirm whether a file is executable or not (`x` in permissions).
* Combine `find`, `file`, and `cat` for a reliable search–verify–read workflow.
* `c` in `-size 1033c` refers to bytes — useful for exact file size matching.
* Learning to interpret permission bits (`rw-r-----`) helps confirm file accessibility.

---

# OverTheWire: Bandit – Level 06–07

**Date:** 10/25/2025
**Goal:** The password for the next level is stored somewhere on the server and has all of the following properties:

owned by user bandit7
owned by group bandit6
33 bytes in size

---

## Commands used:
```bash
bandit6@bandit:~$ find / -type f -user bandit7 -group bandit6 -size 33c
find: ‘/proc/tty/driver’: Permission denied
find: ‘/proc/1/task/1/fd’: Permission denied
find: ‘/proc/1/task/1/fdinfo’: Permission denied
find: ‘/proc/1/task/1/ns’: Permission denied
find: ‘/proc/1/fd’: Permission denied
find: ‘/proc/1/map_files’: Permission denied
find: ‘/proc/1/fdinfo’: Permission denied
find: ‘/proc/1/ns’: Permission denied
find: ‘/proc/2/task/2/fd’: Permission denied
find: ‘/proc/2/task/2/fdinfo’: Permission denied
find: ‘/proc/2/task/2/ns’: Permission denied
find: ‘/proc/2/fd’: Permission denied
find: ‘/proc/2/map_files’: Permission denied
find: ‘/proc/2/fdinfo’: Permission denied
find: ‘/proc/2/ns’: Permission denied
find: ‘/proc/21/task/21/fdinfo/6’: No such file or directory
find: ‘/proc/21/fdinfo/5’: No such file or directory
find: ‘/lost+found’: Permission denied
find: ‘/var/tmp’: Permission denied
find: ‘/var/spool/bandit24’: Permission denied
find: ‘/var/spool/cron/crontabs’: Permission denied
find: ‘/var/spool/rsyslog’: Permission denied
find: ‘/var/lib/update-notifier/package-data-downloads/partial’: Permission denied
find: ‘/var/lib/apt/lists/partial’: Permission denied
find: ‘/var/lib/polkit-1’: Permission denied
find: ‘/var/lib/chrony’: Permission denied
find: ‘/var/lib/udisks2’: Permission denied
find: ‘/var/lib/snapd/cookie’: Permission denied
find: ‘/var/lib/snapd/void’: Permission denied
find: ‘/var/lib/private’: Permission denied
find: ‘/var/lib/ubuntu-advantage/apt-esm/var/lib/apt/lists/partial’: Permission denied
/var/lib/dpkg/info/bandit7.password 
find: ‘/var/lib/amazon’: Permission denied
find: ‘/var/crash’: Permission denied
find: ‘/var/cache/apt/archives/partial’: Permission denied
find: ‘/var/cache/pollinate’: Permission denied
find: ‘/var/cache/private’: Permission denied
find: ‘/var/cache/apparmor/208b6430.0’: Permission denied
find: ‘/var/cache/apparmor/0fb44ac6.0’: Permission denied
find: ‘/var/cache/ldconfig’: Permission denied
find: ‘/var/log’: Permission denied
find: ‘/sys/kernel/tracing/osnoise’: Permission denied
find: ‘/sys/kernel/tracing/hwlat_detector’: Permission denied
find: ‘/sys/kernel/tracing/instances’: Permission denied
find: ‘/sys/kernel/tracing/trace_stat’: Permission denied
find: ‘/sys/kernel/tracing/per_cpu’: Permission denied
find: ‘/sys/kernel/tracing/options’: Permission denied
find: ‘/sys/kernel/tracing/rv’: Permission denied
find: ‘/sys/kernel/debug’: Permission denied
find: ‘/sys/fs/pstore’: Permission denied
find: ‘/sys/fs/bpf’: Permission denied
find: ‘/drifter/drifter14_src/axTLS’: Permission denied
find: ‘/tmp’: Permission denied
find: ‘/snap’: Permission denied
find: ‘/home/bandit31-git’: Permission denied
find: ‘/home/leviathan4/.trash’: Permission denied
find: ‘/home/drifter8/chroot’: Permission denied
find: ‘/home/bandit29-git’: Permission denied
find: ‘/home/bandit27-git’: Permission denied
find: ‘/home/drifter6/data’: Permission denied
find: ‘/home/bandit5/inhere’: Permission denied
find: ‘/home/bandit28-git’: Permission denied
find: ‘/home/leviathan0/.backup’: Permission denied
find: ‘/home/ubuntu’: Permission denied
find: ‘/home/bandit30-git’: Permission denied
find: ‘/boot/efi’: Permission denied
find: ‘/boot/lost+found’: Permission denied
find: ‘/run/pam_pidns’: Permission denied
find: ‘/run/udisks2’: Permission denied
find: ‘/run/chrony’: Permission denied
find: ‘/run/user/11021’: Permission denied
find: ‘/run/user/11023’: Permission denied
find: ‘/run/user/11015’: Permission denied
find: ‘/run/user/12007’: Permission denied
find: ‘/run/user/11031’: Permission denied
find: ‘/run/user/14002’: Permission denied
find: ‘/run/user/12000’: Permission denied
find: ‘/run/user/11002’: Permission denied
find: ‘/run/user/11014’: Permission denied
find: ‘/run/user/11019’: Permission denied
find: ‘/run/user/11026’: Permission denied
find: ‘/run/user/11001’: Permission denied
find: ‘/run/user/14008’: Permission denied
find: ‘/run/user/11010’: Permission denied
find: ‘/run/user/14000’: Permission denied
find: ‘/run/user/11020’: Permission denied
find: ‘/run/user/11024’: Permission denied
find: ‘/run/user/11013’: Permission denied
find: ‘/run/user/8005’: Permission denied
find: ‘/run/user/11009’: Permission denied
find: ‘/run/user/11016’: Permission denied
find: ‘/run/user/11011’: Permission denied
find: ‘/run/user/11007’: Permission denied
find: ‘/run/user/11008’: Permission denied
find: ‘/run/user/11004’: Permission denied
find: ‘/run/user/11000’: Permission denied
find: ‘/run/user/11006/systemd/inaccessible/dir’: Permission denied
find: ‘/run/user/11012’: Permission denied
find: ‘/run/user/11005’: Permission denied
find: ‘/run/sudo’: Permission denied
find: ‘/run/screen/S-bandit19’: Permission denied
find: ‘/run/screen/S-bandit20’: Permission denied
find: ‘/run/multipath’: Permission denied
find: ‘/run/cryptsetup’: Permission denied
find: ‘/run/lvm’: Permission denied
find: ‘/run/systemd/propagate/fwupd.service’: Permission denied
find: ‘/run/systemd/propagate/ModemManager.service’: Permission denied
find: ‘/run/systemd/propagate/polkit.service’: Permission denied
find: ‘/run/systemd/propagate/chrony.service’: Permission denied
find: ‘/run/systemd/propagate/systemd-logind.service’: Permission denied
find: ‘/run/systemd/propagate/irqbalance.service’: Permission denied
find: ‘/run/systemd/propagate/systemd-networkd.service’: Permission denied
find: ‘/run/systemd/propagate/systemd-resolved.service’: Permission denied
find: ‘/run/systemd/propagate/systemd-udevd.service’: Permission denied
find: ‘/run/systemd/inaccessible/dir’: Permission denied
find: ‘/run/lock/lvm’: Permission denied
find: ‘/etc/multipath’: Permission denied
find: ‘/etc/stunnel’: Permission denied
find: ‘/etc/credstore.encrypted’: Permission denied
find: ‘/etc/sudoers.d’: Permission denied
find: ‘/etc/xinetd.d’: Permission denied
find: ‘/etc/polkit-1/rules.d’: Permission denied
find: ‘/etc/credstore’: Permission denied
find: ‘/etc/ssl/private’: Permission denied
find: ‘/root’: Permission denied
find: ‘/manpage/manpage3-pw’: Permission denied
find: ‘/dev/mqueue’: Permission denied
find: ‘/dev/shm’: Permission denied
bandit6@bandit:~$ find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null
/var/lib/dpkg/info/bandit7.password
bandit6@bandit:~$ cat /var/lib/dpkg/info/bandit7.password
<password>
````

---

## Issue Encountered

The first attempt to search the filesystem returned hundreds of Permission denied messages, making it difficult to spot the file that matched the criteria.
This was caused by searching from / without filtering error output.

---

## About the Commands

find / -type f -user bandit7 -group bandit6 -size 33c 2>/dev/null – Searches the entire filesystem (/) for regular files (-type f) owned by user bandit7 and group bandit6, exactly 33 bytes in size (-size 33c).
2>/dev/null – Redirects all error messages (like Permission denied) to “nowhere,” so only accessible files are shown. This filters out noise and allows you to see candidate files quickly.

file <path> – Shows the type of file, confirming if it is human-readable text.
ls -l <path> – Lists file details, including permissions, owner, group, and size.
stat -c '%n: %u %g %s bytes' <path> – Provides a concise display of filename, user ID, group ID, and size in bytes.
cat <path> – Displays the contents of the file (used to read the password once verified).

---

## Key Takeaways

Searching system directories as a non-root user will produce many Permission denied messages; 2>/dev/null is essential to hide these errors.

Using find with multiple conditions (-user, -group, -size) allows you to precisely locate files with specific ownership and size.

Always verify the candidate file with file, ls -l, or stat before reading with cat.

Understanding file permissions helps determine if you can read the file without being root.

This approach is reusable for future levels with specific ownership, group, or size requirements.

---

# OverTheWire: Bandit – Level 07–08

**Date:** 10/25/2025
**Goal:** The password for the next level is stored in the file data.txt next to the word millionth

---

## Commands used:
```bash
bandit7@bandit:~$ ls
data.txt
bandit7@bandit:~$ grep millionth data.txt
millionth       <password>
bandit7@bandit:~$ grep -n millionth data.txt
830:millionth   <password>
#using the -n gives the same result showing which line in the text its on
bandit7@bandit:~$
```
---

## Issue Encountered

No errors — straightforward search-and-extract. The file data.txt contained the keyword millionth followed by the token that serves as the next-level password.

---

## Commands Used / Notes

locate line containing the exact word "millionth"

grep 'millionth' data.txt

(optional) print only the token after "millionth" using PCRE (if supported)

grep -oP '(?<=\bmillionth\s)\S+' data.txt


## Brief explanation of grep usage

grep 'millionth' data.txt searches each line of data.txt for the string millionth. It prints each matching entire line.

grep -n 'millionth' data.txt does the same but also prefixes each matching line with its line number (-n is only for line numbers; it does not change the matched text).

grep -oP '(?<=\bmillionth\s)\S+' data.txt uses PCRE (-P) and prints only the non-space token immediately following millionth (-o prints only the matched part). Use this if your system’s grep supports -P; otherwise use awk/sed.

---

## Key Takeaways

grep prints the whole line containing the match by default — that is often sufficient when the password is the token next to the keyword.

-n only adds line numbers and is optional when you only need the matched content.

Use grep -oP (or awk/sed) to extract just the token following a keyword when you want to copy it cleanly.
