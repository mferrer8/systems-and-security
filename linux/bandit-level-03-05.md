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
2WmrDFRmJIq3IPxneAaMGhap0pFhF3NJ

```

### ✅ Key Points:
using ls -a lists all directories/files in the current directory, including . (current) and ..(parent dir), and hidden files
using ls -A lists all files/dir excluding the current and parent 

