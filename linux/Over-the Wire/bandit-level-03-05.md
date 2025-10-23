# OverTheWire: Bandit – Levels 03–05

 
**Objective:** Learn Linux command-line basics, SSH usage, and file navigation through the first few Bandit levels.

---

## 🧱 Level 2-3 **Date:** [10/22/2025] 
**Goal:** The password for the next level is stored in a file called --spaces in this filename-- located in the home director

**Commands used:**
```bash
cat ./--spaces\ in\ this\ filename--
```

### ✅ Key Points:
If your file name begins with -- (e.g., --my_file.txt), you need to tell the command that the -- is part of the filename and not an option. 
You can do this by: Using ./ before the filename: This explicitly tells the shell that you're referring to a file in the current directory.

---

## 🧱 Level 3-4 **Date:** [10/22/2025] 
**Goal:** The password for the next level is stored in a hidden file in the inhere directory.

**Commands used:**
```bash
bandit3@bandit:~$ ls
inhere
bandit3@bandit:~$ cd inhere/
bandit3@bandit:~/inhere$ ls
bandit3@bandit:~/inhere$ ls -a
.  ..  ...Hiding-From-You
bandit3@bandit:~/inhere$ ls -A
...Hiding-From-You
bandit3@bandit:~/inhere$ cat ./...Hiding-From-You
<password>

```

### ✅ Key Points:
using ls -a lists all directories/files in the current directory, including . (current) and ..(parent dir), and hidden files
using ls -A lists all files/dir excluding the current and parent 

---
## 🧱 Level 2-3 **Date:** [10/22/2025] 
**Goal:** The password for the next level is stored in a file called --spaces in this filename-- located in the home director

**Commands used:**
```bash
cat ./--spaces\ in\ this\ filename--
```

### ✅ Key Points:
If your file name begins with -- (e.g., --my_file.txt), you need to tell the command that the -- is part of the filename and not an option. 
You can do this by: Using ./ before the filename: This explicitly tells the shell that you're referring to a file in the current directory.

---

## 🧱 Level 4-5 **Date:** [10/23/2025] 
**Goal:** The password for the next level is stored in the only human-readable file in the inhere directory. Tip: if your terminal is messed up, try the “reset” command.

**Commands used:**
```bash
bandit4@bandit:~$ ls
inhere
bandit4@bandit:~$ cd inhere/
bandit4@bandit:~/inhere$ ls
-file00  -file01  -file02  -file03  -file04  -file05  -file06  -file07  -file08  -file09
# Attempt to identify file types (this fails because filenames start with '-')
bandit4@bandit:~/inhere$ file * 
file: Cannot open `ile00' (No such file or directory)
file: Cannot open `ile01' (No such file or directory)
file: Cannot open `ile02' (No such file or directory)
file: Cannot open `ile03' (No such file or directory)
file: Cannot open `ile04' (No such file or directory)
file: Cannot open `ile05' (No such file or directory)
file: Cannot open `ile06' (No such file or directory)
file: Cannot open `ile07' (No such file or directory)
file: Cannot open `ile08' (No such file or directory)
file: Cannot open `ile09' (No such file or directory)
# Corrected command — use './*' to reference files in the current directory
bandit4@bandit:~/inhere$ file ./*
./-file00: data
./-file01: data
./-file02: data
./-file03: data
./-file04: data
./-file05: data
./-file06: data
./-file07: ASCII text
./-file08: data
./-file09: data
bandit4@bandit:~/inhere$ cat ./-file07
<password>

```

## ⚠️ Issue Encountered

The command `file *` failed because filenames began with a dash (`-`), causing them to be interpreted as command options.  
Using `./*` tells the shell to treat them as files in the current directory, resolving the error.

---

## 💡 About the `file` Command

`file` identifies the type of a file by examining its contents rather than its extension.  
Using `file ./*` lists the type of every file in the directory, making it easy to spot which one is readable text.

---

## ✅ Key Takeaways

- Use `file` to determine what kind of data a file contains.  
- Prefix filenames with `./` when they start with `-`.  
- Combine `ls`, `file`, and `cat` for efficient file inspection.  
- Small syntax issues can reveal important details about how Linux interprets commands.
