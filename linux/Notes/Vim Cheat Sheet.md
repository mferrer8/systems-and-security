# Vim Cheat Sheet

### Essential Commands for Sysadmins, SOC Analysts, and Pentesters

*(vi-compatible)*

---

## Starting and Exiting

| Command             | Description                      |
| ------------------- | -------------------------------- |
| `vi filename`       | Open (or create) a file.         |
| `:e filename`       | Open another file.               |
| `:w`                | Save current file.               |
| `:w filename`       | Save as new name.                |
| `:q`                | Quit (fails if unsaved changes). |
| `:q!`               | Quit without saving.             |
| `:wq` / `ZZ` / `:x` | Save and quit.                   |
| `:qa!`              | Quit all files without saving.   |

**SOC Analyst / Pentester Note:**
Always save backups (e.g., `:w /tmp/backup.conf`) before editing configs or logs during investigations or exploitation.

---

## Modes Overview

| Mode                         | Description                                       | Enter                         | Exit                                 |
| ---------------------------- | ------------------------------------------------- | ----------------------------- | ------------------------------------ |
| **Normal (Command)**         | Default mode for navigation and editing commands. | Start or press `Esc`.         | Use `i`, `a`, `o`, or `:` to switch. |
| **Insert**                   | Used for entering text.                           | `i`, `I`, `a`, `A`, `o`, `O`. | Press `Esc`.                         |
| **Visual**                   | Used for selecting text blocks.                   | `v`, `V`, `Ctrl-v`.           | Press `Esc`.                         |
| **Last-Line (Command-Line)** | Used for extended commands (save, quit, search).  | `:`                           | Press `Enter`.                       |

---

## Navigation

| Command             | Action                          |
| ------------------- | ------------------------------- |
| `h`, `j`, `k`, `l`  | Left, down, up, right.          |
| `0`                 | Start of line.                  |
| `$`                 | End of line.                    |
| `w` / `b`           | Next / previous word.           |
| `G` / `gg`          | End / start of file.            |
| `Ctrl-f` / `Ctrl-b` | Page forward / backward.        |
| `:n`                | Go to line *n*.                 |
| `%`                 | Jump between matching brackets. |

**SOC Tip:**
Quick movement is essential when analyzing large configuration or log files on remote shells.

---

## Editing Basics

| Command   | Description                            |
| --------- | -------------------------------------- |
| `x`       | Delete character under cursor.         |
| `dd`      | Delete current line.                   |
| `dw`      | Delete from cursor to next word start. |
| `u`       | Undo last change.                      |
| `Ctrl-r`  | Redo undone change.                    |
| `.`       | Repeat last command.                   |
| `yy`      | Yank (copy) current line.              |
| `p` / `P` | Paste after / before cursor.           |
| `r<char>` | Replace a single character.            |
| `J`       | Join next line to current line.        |

**SOC / Pentest Note:**
Use `yy` + `p` to duplicate and comment sensitive config lines before modification — preserves traceability.

---

## Inserting and Appending Text

| Command | Description           |
| ------- | --------------------- |
| `i`     | Insert before cursor. |
| `I`     | Insert at line start. |
| `a`     | Append after cursor.  |
| `A`     | Append at line end.   |
| `o`     | Open new line below.  |
| `O`     | Open new line above.  |

---

## Searching and Replacing

| Command          | Description                    |
| ---------------- | ------------------------------ |
| `/pattern`       | Search forward for pattern.    |
| `?pattern`       | Search backward.               |
| `n` / `N`        | Repeat search next / previous. |
| `:%s/old/new/g`  | Replace all in file.           |
| `:s/old/new/g`   | Replace all in current line.   |
| `:%s/old/new/gc` | Replace all with confirmation. |

**SOC Tip:**
Use `/failed` or `/root` when hunting through `/var/log/auth.log` for brute-force or privilege escalation activity.

---

## Visual Mode Operations (vim only)

| Command       | Description                           |
| ------------- | ------------------------------------- |
| `v`           | Start character selection.            |
| `V`           | Start line selection.                 |
| `Ctrl-v`      | Start block (column) selection.       |
| `y`, `d`, `p` | Yank (copy), delete, paste selection. |

**Pentester Tip:**
Block selection (`Ctrl-v`) is invaluable for modifying columns of IPs, ACLs, or access control entries.

---

## Combining Commands

| Example | Meaning                                |
| ------- | -------------------------------------- |
| `3w`    | Move three words forward.              |
| `2dd`   | Delete two lines.                      |
| `d$`    | Delete from cursor to end of line.     |
| `y0`    | Copy from cursor to beginning of line. |
| `5yy`   | Copy five lines.                       |

**SOC Tip:**
Efficient combined commands reduce keystrokes and time spent editing massive configuration files.

---

## Save, Reload, and File Management

| Command          | Description                           |
| ---------------- | ------------------------------------- |
| `:w`             | Save current file.                    |
| `:e filename`    | Open another file.                    |
| `:n` / `:N`      | Next / previous file in list.         |
| `:r filename`    | Insert contents of another file here. |
| `:!command`      | Run a shell command.                  |
| `:w !sudo tee %` | Save a read-only file with sudo.      |

**SOC Tip:**
`:!command` is powerful for on-host triage — you can run `:!ls -la` or `:!cat /etc/passwd` without exiting vim.

---

## Useful Settings (`:set`)

| Command           | Description                 |
| ----------------- | --------------------------- |
| `:set number`     | Show line numbers.          |
| `:set nonumber`   | Hide line numbers.          |
| `:set ignorecase` | Case-insensitive searches.  |
| `:set hlsearch`   | Highlight search results.   |
| `:set nohlsearch` | Clear highlights.           |
| `:set syntax=on`  | Enable syntax highlighting. |
| `:set tabstop=4`  | Define tab width.           |
| `:set expandtab`  | Use spaces instead of tabs. |

**SOC Note:**
Line numbers and highlights help quickly reference findings in configuration or evidence files during reports.

---

## Configuration File (`~/.vimrc`)

Example:

```bash
set number
set hlsearch
set ignorecase
syntax on
set tabstop=4
set expandtab
```

* Loaded automatically on startup.
* Global config at `/etc/vim/vimrc`.

**SOC Tip:**
Inspect `.vimrc` for persistence mechanisms or malicious autocommands that might execute code on shell start.

---

## Recovery and Backups

| Command           | Description                             |
| ----------------- | --------------------------------------- |
| `vim -r filename` | Recover from swap file after crash.     |
| `.filename.swp`   | Temporary recovery file created by vim. |

**Security Note:**
Check and secure `.swp` files — they may contain sensitive fragments from previous editing sessions.

---

## TL;DR Quick Reference

**Modes:**

* `Esc` → Command mode
* `i`, `a`, `o` → Insert mode
* `:` → Last-line mode

**Navigation:**
`h j k l`, `0`, `$`, `w`, `b`, `G`, `gg`, `Ctrl-f`, `Ctrl-b`

**Editing:**
`x`, `dd`, `yy`, `p`, `u`, `.`, `r<char>`, `dw`, `J`

**Search & Replace:**
`/pattern`, `:%s/old/new/g`

**Save/Quit:**
`:w`, `:q`, `:wq`, `:q!`, `ZZ`

**Visual Mode:**
`v`, `V`, `Ctrl-v`, `y`, `d`, `p`

**Settings:**
`:set number`, `:set hlsearch`, `:set syntax=on`

---
