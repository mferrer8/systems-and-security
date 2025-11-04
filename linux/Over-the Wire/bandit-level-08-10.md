# OverTheWire: Bandit – Level 08–09

**Date:** 11/04/2025
**Goal:** The password for the next level is stored in the file `data.txt` and is the only line of text that occurs only once.

---

## Commands Used:

```bash
bandit8@bandit:~$ ls
data.txt
bandit8@bandit:~$ sort data.txt | uniq -u
<password>
bandit8@bandit:~$
```

---

## Issue Encountered

No major issues encountered. Initially, it may be unclear how to detect unique lines in a large dataset, but combining sorting and uniqueness filtering provides an elegant and efficient solution.

---

## About the Commands

`sort data.txt` – Sorts all lines alphabetically. This is required before using `uniq`, as `uniq` only detects adjacent duplicates.

`uniq -u` – Displays only lines that appear **exactly once** in the input stream (unique lines).

`sort data.txt | uniq -u` – Combines both commands using a **pipe (|)**. The `sort` command outputs its results to `uniq`, which filters and prints the single-occurring line containing the password.

---

## Brief Summary of Piping and Redirection

* **Piping (`|`)** connects the output of one command directly into the input of another.
  Example: `sort data.txt | uniq -u` means "sort the data, then pass it to `uniq`."
* **Redirection (`>`, `>>`, `<`)** controls where input and output go.

  * `>` sends output to a file (overwrites).
  * `>>` appends output to a file.
  * `<` takes input from a file.
  * `2>` redirects error messages.

---

## Key Takeaways

* `uniq` requires sorted input to function correctly—always pipe from `sort` when filtering duplicates.
* `uniq -u` isolates lines that appear only once—useful for finding hidden or unique tokens.
* Piping (`|`) is a core Linux concept for chaining commands efficiently.
* Redirection (`>`, `>>`, `2>`) helps manage outputs and errors for cleaner workflows.
* Mastering these text-processing commands is critical for analyzing log data and extracting key information quickly.

---

Below is a ready-to-paste **Markdown** file for your repo (Level 09 → 10). I used your provided commands and output but **redacted the actual password**. Copy this into a new `.md` and commit.

---

# OverTheWire: Bandit – Level 09 → 10

**Date:** 11/04/2025
**Goal:** The password for the next level is stored in `data.txt` in one of the few human‑readable strings, preceded by several `=` characters.

---

## Commands used

```bash
# extract printable strings from the (possibly binary) file and look for runs of '='
strings data.txt | grep -E '^={4,}'
# sample output (no password shown):
========== the
========== password

# relaxed search (match '====' anywhere in the line)
strings data.txt | grep '===='
# sample output (password line redacted):
========== the
========== password
E========== is
5========== [REDACTED]
```

---

## Issue Encountered

Initial attempt used a pattern anchored to the start of the line (`^={4,}`), which returned only lines where the `=` run was at the beginning of the `strings` output line. That missed additional readable fragments where the `=` characters were not at position 1 of the extracted `strings` line. The output looked like binary garbage mixed with readable fragments when using plain `grep` directly on the file, so `strings` was necessary to extract printable fragments first.

---

## About the Commands & Syntax

* `strings data.txt`
  Extracts sequences of printable characters from a binary or mixed file and prints them line by line. Useful when the file contains non‑printable bytes that would otherwise corrupt terminal output.

* `grep -E '^={4,}'`
  Uses extended regular expressions (`-E`) to match lines that **start** with four or more `=` characters. `^` anchors the pattern to the beginning of the line; `={4,}` means “four or more equals signs.”

* `grep '===='`
  A simpler pattern that matches any line containing four consecutive `=` characters anywhere in the line. This is less strict than the anchored pattern and therefore catches matches regardless of their position in the `strings` output.

* Example to strip the leading `=` run and show the token after it (do this locally; do not publish the token):

```bash
# using sed to remove leading = characters and surrounding whitespace
strings data.txt | sed -n 's/^=\\{4,\\}[[:space:]]*//p'
```

Or, to capture the first non-space token after the `=` run:

```bash
strings data.txt | sed -n 's/^=\\{4,\\}[[:space:]]*\\(\\S\\+\\).*/\\1/p'
```

(Adjust character class if the token contains unusual characters.)

---

## Why changing to `grep '===='` fixed it

* The anchored pattern `^={4,}` requires the `=` run to be at the very **start** of the line. In the `strings` output, the printable fragments that include the `=` run were not always at column 1 — sometimes they were preceded by a printable character or other fragment.
* By switching to a non‑anchored search (`grep '===='`), you match **any** line that contains four `=` characters in a row, regardless of position. That finds the extra lines that the anchored pattern missed and yields the readable candidate lines containing the password.

---

## Key Takeaways

* Use `strings` on binary or mixed files first to extract printable fragments — it prevents terminal corruption and makes subsequent `grep` output readable.
* Anchored regex (`^...`) only matches at a specific position (line start); remove the anchor to match occurrences anywhere in the line.
* For extraction, prefer `sed`, `awk`, or `grep -oP` (if available) to strip the `=` run and isolate the token cleanly.
* Never paste the actual password into public places — keep it private in your notes or local files.
* This approach (strings → grep → sed/awk) is a reliable pattern for extracting human-readable tokens buried in binary blobs.

---
