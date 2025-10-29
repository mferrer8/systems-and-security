# Chapter 12 – A Gentle Introduction to vi(m)

## Overview

* **vi** is one of the oldest and most universal text editors on Unix/Linux systems.
* **vim (Vi IMproved)** is its enhanced modern form, included on nearly all distributions.
* Mastering vi is essential because it is **always available**, even in recovery shells or minimal environments.
* Unlike GUI editors, vi is **keyboard-driven** and operates in **modes**, making it extremely efficient once familiar.

🔹 **SOC Analyst / Pentester Note:**
Being comfortable in vi is critical when editing configs, logs, or scripts on compromised or minimal systems during incident response or post-exploitation.

---

## Modes of Operation

| Mode                    | Description                                                         | Enter                         | Exit                                       |
| ----------------------- | ------------------------------------------------------------------- | ----------------------------- | ------------------------------------------ |
| **Command Mode**        | Default mode; used for navigation and issuing editing commands.     | On file open or press `Esc`.  | `i`, `a`, or `o` for insert.               |
| **Insert Mode**         | For text input.                                                     | `i`, `I`, `a`, `A`, `o`, `O`. | `Esc` returns to Command mode.             |
| **Last-Line (Ex) Mode** | For executing extended commands like `:w`, `:q`, or search/replace. | `:` from Command mode.        | `Enter` executes, returns to Command mode. |

🔹 **SOC Note:**
Understanding these modes helps prevent mistakes when rapidly editing configuration files such as `/etc/passwd` or firewall rules — accidental insert mode changes can break services.

---

## Opening and Closing Files

| Command       | Action                           |
| ------------- | -------------------------------- |
| `vi filename` | Open (create if not existing).   |
| `:q`          | Quit (fails if unsaved changes). |
| `:q!`         | Quit discarding changes.         |
| `:w`          | Save file.                       |
| `:w filename` | Save to new name.                |
| `:wq` or `ZZ` | Save and quit.                   |

🔹 **SOC Note:**
When performing forensic triage or modifying logs, always make copies (`:w /tmp/backup.log`) before editing originals to preserve evidence.

---

## Navigation in Command Mode

| Keys                | Action                          |
| ------------------- | ------------------------------- |
| `h`                 | Move left.                      |
| `j`                 | Move down.                      |
| `k`                 | Move up.                        |
| `l`                 | Move right.                     |
| `0`                 | Jump to line start.             |
| `$`                 | Jump to line end.               |
| `w`                 | Jump to next word start.        |
| `b`                 | Jump to previous word start.    |
| `G`                 | Go to end of file.              |
| `gg`                | Go to beginning of file.        |
| `Ctrl-f` / `Ctrl-b` | Scroll forward/back one screen. |
| `:n`                | Jump to line *n* (e.g., `:20`). |

🔹 **Pentester Tip:**
During exploitation, config files like `/etc/sudoers` or `/etc/ssh/sshd_config` may be lengthy. Knowing motion shortcuts saves time while editing under restrictive conditions.

---

## Basic Editing Commands

| Command      | Function                               |
| ------------ | -------------------------------------- |
| `x`          | Delete character under cursor.         |
| `dd`         | Delete current line.                   |
| `dw`         | Delete from cursor to next word start. |
| `u`          | Undo last change.                      |
| `Ctrl-r`     | Redo last undone change.               |
| `.`          | Repeat last change.                    |
| `yy`         | Yank (copy) current line.              |
| `p`          | Paste after cursor/line.               |
| `P`          | Paste before cursor/line.              |
| `r` + *char* | Replace a single character.            |

🔹 **SOC Note:**
When modifying system scripts or log files, use `yy`/`p` to duplicate and comment original lines instead of deleting — preserves audit trail.

---

## Searching and Replacing

| Command          | Description                      |
| ---------------- | -------------------------------- |
| `/pattern`       | Search forward for *pattern*.    |
| `?pattern`       | Search backward.                 |
| `n` / `N`        | Repeat search next/previous.     |
| `:%s/old/new/g`  | Replace all occurrences in file. |
| `:s/old/new/g`   | Replace all in current line.     |
| `:%s/old/new/gc` | Replace with confirmation each.  |

🔹 **SOC Analyst Note:**
Use vi search when parsing large logs (e.g., `/var/log/auth.log`) to quickly locate IPs, usernames, or keywords such as “failed” or “root”.

---

## Visual Selection Mode (vim-only)

| Mode          | Use                                   |
| ------------- | ------------------------------------- |
| `v`           | Start character-wise selection.       |
| `V`           | Start line-wise selection.            |
| `Ctrl-v`      | Start block (column) selection.       |
| `y`, `d`, `p` | Copy, delete, or paste selected text. |

🔹 **Pentester Tip:**
Block-wise visual selection (`Ctrl-v`) is great for editing repetitive configuration patterns, ACL entries, or table-formatted data.

---

## Combining Commands (Counts & Motions)

* Prefix motions with numbers for repetition:

  * `3w` → move three words forward.
  * `2dd` → delete two lines.
* Combine commands and motions:

  * `d$` → delete from cursor to end of line.
  * `y0` → copy from cursor to start of line.

🔹 **SOC Note:**
Efficient command chaining allows faster triage edits under time pressure (e.g., removing hundreds of lines of temporary debug output).

---

## Inserting and Appending Text

| Command | Effect                   |
| ------- | ------------------------ |
| `i`     | Insert before cursor.    |
| `I`     | Insert at start of line. |
| `a`     | Append after cursor.     |
| `A`     | Append at end of line.   |
| `o`     | Open new line below.     |
| `O`     | Open new line above.     |

🔹 **SOC Tip:**
Appending (`A`) is useful when commenting configuration lines at the end (e.g., adding `# disabled for audit`).

---

## Saving Work and Quitting

* `:w` – write/save file.
* `:w filename` – save under new name.
* `:q` – quit.
* `:q!` – force quit without saving.
* `:wq` or `ZZ` – save and quit.
* `:x` – same as `:wq`.

Always verify file permissions; use `sudo vim /path/to/file` for protected files.

🔹 **SOC Note:**
When editing in restricted shells, confirm file writes with `ls -l` to ensure your changes persist.

---

## Useful vim Options (`:set`)

| Option            | Description                 |
| ----------------- | --------------------------- |
| `:set number`     | Show line numbers.          |
| `:set nonumber`   | Hide line numbers.          |
| `:set ignorecase` | Case-insensitive search.    |
| `:set hlsearch`   | Highlight matches.          |
| `:set nohlsearch` | Remove highlights.          |
| `:set syntax=on`  | Enable syntax highlighting. |

🔹 **SOC Tip:**
Line numbers (`:set number`) make cross-referencing log lines or code snippets more efficient during investigations.

---

## Editing Multiple Files

| Command           | Description                                         |
| ----------------- | --------------------------------------------------- |
| `:e filename`     | Edit another file.                                  |
| `:n` / `:N`       | Move to next/previous file in argument list.        |
| `:args`           | Show file list.                                     |
| `:split filename` | Split window to edit multiple files simultaneously. |

---

## Configuration File – `~/.vimrc`

Custom startup file defining defaults. Example:

```vim
set number
set hlsearch
set ignorecase
syntax on
set tabstop=4
set expandtab
```

* Load automatically on vim startup.
* System-wide defaults: `/etc/vim/vimrc`.

🔹 **SOC Note:**
Inspect `.vimrc` for malicious macros or autocommands; attackers may implant persistence or keylogging scripts here.

---

## Recovery and Backup

* If vim crashes or system reboots unexpectedly, recovery files like `.filename.swp` appear.
* Use:

  ```bash
  vim -r filename
  ```

  to recover unsaved changes.

🔹 **SOC Tip:**
Recovered `.swp` files can leak sensitive credentials or in-progress configuration data — review and securely delete after analysis.

---

## Practical vi Workflow Example

1. Open config file: `vi /etc/ssh/sshd_config`
2. Search for root login line: `/PermitRootLogin`
3. Enter insert mode: `i`
4. Modify value (e.g., `no`)
5. Save and exit: `:wq`

---

## Common Troubleshooting

* **Accidentally typed nonsense?** Press `Esc` repeatedly to return to Command mode.
* **Stuck in read-only file?** Use `:w! filename` to force write (if permissions allow).
* **Need to quit immediately?** Type `:q!` to exit without saving.

---

## TL;DR Summary – Key Takeaways & Commands

### Essentials

* **Modes:** Command (`Esc`), Insert (`i`/`a`/`o`), Last-Line (`:`).
* **Save/Quit:** `:w`, `:q`, `:wq`, `:q!`, `ZZ`.
* **Navigation:** `h j k l`, `0 $ w b G gg`.
* **Editing:** `x`, `dd`, `yy`, `p`, `u`, `.`, `r`.
* **Search/Replace:** `/pattern`, `:%s/old/new/g`.
* **Visual Mode:** `v`, `V`, `Ctrl-v`.
* **Settings:** `:set number`, `:set syntax=on`.
* **Customization:** Edit `~/.vimrc`.

### SOC / Pentester Highlights

* vi is always available in minimal or recovery shells.
* Edit configs safely — backup before writing (`:w /tmp/backup.conf`).
* Examine `.vimrc` for persistence artifacts.
* Use vi for rapid log searches and on-host triage edits.
* Recognize recovery `.swp` files as potential data leakage points.

---
