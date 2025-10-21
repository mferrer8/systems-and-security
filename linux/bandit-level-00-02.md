# OverTheWire: Bandit – Levels 0–2

**Date:** [10/21/2025]  
**Objective:** Learn Linux command-line basics, SSH usage, and file navigation through the first few Bandit levels.

---

## 🧱 Level 0
**Goal:** Connect to the Bandit server via SSH.

**Commands used:**
```bash
ssh username@bandit.labs.overthewire.org -p number
```

### ✅ Key Points:
Practiced logging into a remote Linux machine using SSH.
Learned to connect to a non-standard port.

---

## 🧱 Level 0 - 1
**Goal:**The password for the next level is stored in a file called readme located in the home directory. Use this password to log into bandit1 using SSH. Whenever you find a password for a level, use SSH (on port 2220) to log into that level and continue the game.

**Commands used:**
```bash
cat fileneame
```
note: password found. saved to local machine

### ✅ Key Points:
leveraged the cat command
The cat command in Unix-like operating systems (including Linux and macOS) is a fundamental utility primarily used for concatenating and displaying file contents. The name "cat" is an abbreviation for "concatenate."
Here are its primary uses:
Displaying File Contents: The most common use is to display the entire content of one or more files directly to the standard output (usually your terminal).
---

## 🧱 Level 1 - 2
**Goal:**The password for the next level is stored in a file called - located in the home directory

**Commands used:**
```bash
cat ./-
```

### ✅ Key Points:
if you want to open this type of file you have to specify the full location of the file such as ./- 
Both cat < - and ./- command will give you the output
