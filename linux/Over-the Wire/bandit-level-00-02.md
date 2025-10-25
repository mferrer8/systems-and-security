# OverTheWire: Bandit – Levels 0–2

**Date:** 10/21/2025  
**Objective:** Learn Linux command-line basics, SSH usage, and file navigation through the first few Bandit levels.

---

## Level 0

**Goal:** Connect to the Bandit server via SSH.

**Commands used:**
```bash
ssh username@bandit.labs.overthewire.org -p number
````

**Summary / Key Points**

* Practiced logging into a remote Linux machine using SSH.
* Learned to connect to a non-standard port.

---

## Level 0 → 1

**Goal:** The password for the next level is stored in a file called `readme` located in the home directory. Use this password to log into `bandit1` using SSH (port 2220).

**Commands used:**

```bash
cat filename
```

**Summary / Key Points**

* Located the password file and saved the password locally.
* Used the `cat` command to display file contents.
* The `cat` command (short for “concatenate”) is primarily used to display the contents of files to standard output and to concatenate files.

---

## Level 1 → 2

**Goal:** The password for the next level is stored in a file named `-` in the home directory.

**Commands used:**

```bash
cat ./-
```

**Summary / Key Points**

* Filenames that begin with `-` can be interpreted as command options.
* Prefixing the filename with `./` forces the shell to treat it as a pathname (e.g., `./-`).
* Both `cat ./-` and redirecting input from `./-` will read the file correctly.

---
