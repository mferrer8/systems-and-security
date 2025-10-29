# Chapter 11 – The Environment

## Overview

* The **shell environment** stores information that programs use to determine system configuration and behavior.
* It includes **variables**, **aliases**, and **functions** that define user and system-wide settings.
* By modifying these, users can customize how the shell operates.

---

## Commands Covered

| Command           | Purpose                                            |
| ----------------- | -------------------------------------------------- |
| `printenv`        | Display all or part of the environment.            |
| `set`             | Display or set shell options and variables.        |
| `export`          | Make variables available to child processes.       |
| `alias`           | Create shorthand for commands.                     |
| `source` (or `.`) | Execute commands from a file in the current shell. |

---

## Environment Contents

### Types of Variables

* **Shell variables** – Defined by the current shell instance; not passed to child processes.
* **Environment variables** – Passed to child processes and used by programs.
* Also includes **aliases** and **shell functions**.

### Viewing Environment Data

```bash
printenv | less     # shows environment variables
set | less          # shows shell + environment variables + functions
echo $HOME          # print value of a single variable
alias               # list defined aliases
```

🔹 **SOC Analyst Note:**
Understanding variables like `PATH`, `USER`, and `SHELL` helps when analyzing process environments in investigations or reverse-engineering malicious scripts.

---

## Common Environment Variables

| Variable  | Description                                           |
| --------- | ----------------------------------------------------- |
| `DISPLAY` | Graphical display name (e.g., `:0`).                  |
| `EDITOR`  | Default text editor.                                  |
| `SHELL`   | User’s login shell.                                   |
| `HOME`    | Path to home directory.                               |
| `LANG`    | Language and character encoding.                      |
| `OLDPWD`  | Previous working directory.                           |
| `PAGER`   | Program for paged output (often `less`).              |
| `PATH`    | Colon-separated directories searched for executables. |
| `PS1`     | Defines shell prompt format.                          |
| `PWD`     | Current working directory.                            |
| `TERM`    | Terminal type/protocol.                               |
| `TZ`      | Time zone setting.                                    |
| `USER`    | Current username.                                     |

🔹 **SOC Analyst Note:**
When examining suspicious processes or cron jobs, environment variables like `PATH` or `LD_PRELOAD` can reveal persistence or privilege-escalation attempts.

---

## How the Environment Is Established

### Shell Session Types

* **Login shell:** Prompted for username/password (e.g., console, SSH, or initial GUI login).
* **Non-login shell:** Typically launched from within a GUI terminal emulator.

### Login Shell Startup Files

| File              | Purpose                                  |
| ----------------- | ---------------------------------------- |
| `/etc/profile`    | Global defaults for all users.           |
| `~/.bash_profile` | User-specific startup script.            |
| `~/.bash_login`   | Used if `.bash_profile` is missing.      |
| `~/.profile`      | Fallback for systems like Ubuntu/Debian. |

### Non-Login Shell Startup Files

| File               | Purpose                                  |
| ------------------ | ---------------------------------------- |
| `/etc/bash.bashrc` | Global configuration.                    |
| `~/.bashrc`        | User configuration; read by most shells. |

* Non-login shells **inherit** environment variables from the parent process (usually a login shell).
* `~/.bashrc` is the **most important** user-level startup file.

🔹 **SOC Analyst Note:**
Startup files can be abused for persistence — check for unauthorized edits or injected commands in `.bashrc`, `.profile`, or `/etc/profile`.

---

## Inside a Typical `.bash_profile`

```bash
# Load user .bashrc if it exists
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Add user bin directory to PATH
PATH=$PATH:$HOME/bin
export PATH
```

* `if [ -f ~/.bashrc ]` ensures `.bashrc` exists before reading it.
* `$PATH:$HOME/bin` appends personal binaries to the PATH.
* `export` makes variables available to child processes.

### Variable Expansion Example

```bash
foo="This is some "
foo=$foo"text."
echo $foo    # => This is some text.
```

---

## Child Processes and Environment Inheritance

* **Shell variables** are local; **environment variables** are inherited.
* **Child processes cannot modify their parent’s environment.**

Example:

```bash
foo="bar"   # defined in parent
bash        # open child shell
echo $foo   # empty, not inherited unless exported
```

Use `export` to make it visible to child processes:

```bash
export foo="bar"
```

🔹 **SOC Analyst Note:**
Environment inheritance can be leveraged by malware for stealth execution. Monitoring inherited variables in process trees is key in incident response.

---

## Temporary Environment for One Command

```bash
MANWIDTH=75 man ls
```

* Assigns `MANWIDTH=75` **only for that command**.
* Can be aliased for convenience:

  ```bash
  alias man='MANWIDTH=75 man'
  ```

---

## Modifying the Environment

### Which Files to Modify

* **`~/.bash_profile`** or **`~/.profile`** → Add to PATH, define environment vars.
* **`~/.bashrc`** → Define aliases, functions, or shell options.
* Avoid editing `/etc/*` unless administering the system.

---

## Text Editors Overview

* **Graphical:** `gedit`, `kate`, `kwrite`.
* **Text-based:** `nano`, `vi`/`vim`, `emacs`.
* Used to edit configuration files like `.bashrc`.

### Example: Editing `.bashrc`

```bash
cp .bashrc .bashrc.bak        # backup
nano .bashrc                  # open for editing
```

Add:

```bash
umask 0002
export HISTCONTROL=ignoredups
export HISTSIZE=1000
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
```

### Meaning of Additions

| Line                            | Description                                |
| ------------------------------- | ------------------------------------------ |
| `umask 0002`                    | Easier shared-directory permissions.       |
| `export HISTCONTROL=ignoredups` | Skip duplicate entries in command history. |
| `export HISTSIZE=1000`          | Keep last 1000 commands in history.        |
| `alias l.` / `alias ll`         | Useful shorthand for listing files.        |

🔹 **SOC Analyst Note:**
`HISTCONTROL` and `HISTSIZE` matter during forensic review — attackers sometimes disable or shrink history to hide tracks. Check these values.

---

## Comments and Documentation

* Lines starting with `#` are **comments**; not executed.
* Used for documentation or disabling lines (commenting out).
* **Uncomment** by removing `#`.
* Always comment your changes and maintain a **change log**.

---

## Activating Changes

* Changes to `.bashrc` apply on **new sessions**.
* To reload immediately:

  ```bash
  source ~/.bashrc
  ```
* `source` (or `.`) executes a file in the current shell environment.

---

## Key Takeaways

* The **environment** defines the shell’s behavior and customization.
* Variables, aliases, and startup files determine session defaults.
* Use **`export`**, **`printenv`**, and **`source`** to manage and inspect the environment.
* **Editing `.bashrc` safely** is fundamental for Linux administration and shell automation.

---

## Further Reading

* `man bash` → *INVOCATION* section details startup file order.
* `man environ` → Environment variable conventions.

---

### 🔹 SOC Analyst Quick Notes

* Review `/etc/profile`, `.bashrc`, `.profile` for persistence mechanisms.
* Monitor for abnormal `PATH` or `LD_PRELOAD` entries.
* Command history (`.bash_history`) reveals user and attacker actions.
* Use `env` or `printenv` during investigations to capture process context.
* Compare environment baselines across user accounts for anomalies.

---
