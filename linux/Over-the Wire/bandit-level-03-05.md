# OverTheWire: Bandit – Levels 03–05

**Objective:** Continue developing Linux command-line fundamentals, focusing on file handling, hidden files, and identifying file types.

---

## Level 2 → 3  
**Date:** 10/22/2025  

**Goal:** The password for the next level is stored in a file called `--spaces in this filename--` located in the home directory.

**Commands used:**
```bash
cat ./--spaces\ in\ this\ filename--
````

**Summary / Key Points**

* When a filename begins with `--`, commands may treat it as an option instead of a name.
* Prefixing the filename with `./` tells the shell it’s a file in the current directory.
* Escaping spaces using `\` or quoting the filename prevents the shell from misinterpreting it.

---

## Level 3 → 4

**Date:** 10/22/2025

**Goal:** The password for the next level is stored in a hidden file inside the `inhere` directory.

**Commands used:**

```bash
ls
cd inhere/
ls -a
ls -A
cat ./...Hiding-From-You
```

**Summary / Key Points**

* Hidden files in Linux begin with a dot (`.`).
* `ls -a` lists all files, including `.` (current directory) and `..` (parent directory).
* `ls -A` lists all files except `.` and `..`.
* Combining `ls` and `cat` allows you to locate and view hidden files efficiently.

---

## Level 4 → 5

**Date:** 10/23/2025

**Goal:** The password for the next level is stored in the only human-readable file in the `inhere` directory.
*Tip:* If your terminal becomes cluttered, use the `reset` command to clear it.

**Commands used:**

```bash
ls
cd inhere/
ls
# Attempt to identify file types (fails because filenames start with '-')
file *
# Corrected command — use './*' to reference files in the current directory
file ./*
cat ./-file07
```

### Issue Encountered

The command `file *` failed because filenames began with a dash (`-`), causing them to be interpreted as command options.
Using `./*` forces the shell to treat them as files in the current directory, resolving the issue.

---

### About the `file` Command

The `file` command identifies the type of a file by examining its contents rather than relying on its extension.
Using `file ./*` lists the type of every file in a directory, making it easy to locate human-readable text files.

---

### Key Takeaways

* Use `file` to determine what kind of data a file contains.
* Prefix filenames with `./` when they begin with `-`.
* Combine `ls`, `file`, and `cat` for efficient file inspection.
* Small syntax errors often reveal how Linux interprets commands and filenames.

---
