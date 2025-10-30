# Bash If Statements — Summary (Ryan’s Tutorials)

## 1. Introduction

* If statements allow scripts to make decisions and execute code conditionally.
* Often combined with loops or case statements for automation.
* Syntax must be precise for correct operation.

---

## 2. Basic If Statements

**Syntax:**

```bash
if [ <test> ]
then
  <commands>
fi
```

* Commands between `then` and `fi` run **only if** the condition is true.
* `fi` marks the end of the if block.
* Always test scripts with different inputs to ensure all cases work.

**Example:**

```bash
if [ $1 -gt 100 ]
then
  echo "Hey that's a large number."
  pwd
fi
date
```

---

## 3. The `test` Command

* `[ ]` in an if statement are a shorthand for the `test` command.
* Use `man test` to see all operators.

### Common Operators

| Operator              | Description                       |
| --------------------- | --------------------------------- |
| ! EXPRESSION          | Negates the result (true → false) |
| -n STRING             | True if string length > 0         |
| -z STRING             | True if string length = 0         |
| STRING1 = STRING2     | Strings are equal                 |
| STRING1 != STRING2    | Strings are not equal             |
| INTEGER1 -eq INTEGER2 | Equal (numeric)                   |
| INTEGER1 -gt INTEGER2 | Greater than (numeric)            |
| INTEGER1 -lt INTEGER2 | Less than (numeric)               |
| -d FILE               | File exists and is a directory    |
| -e FILE               | File exists                       |
| -r FILE               | File is readable                  |
| -s FILE               | File exists and is not empty      |
| -w FILE               | File is writable                  |
| -x FILE               | File is executable                |

### Notes

* `=` does string comparison, `-eq` does numeric comparison.
* `[ 001 = 1 ]` → false; `[ 001 -eq 1 ]` → true.
* `test` returns exit code `0` (true) or `1` (false).
* `$?` stores the exit code of the last command.

---

## 4. Indenting

* Indentation improves readability and prevents errors.
* Not required by Bash but strongly recommended.
* Especially important when scripts become longer or more complex.

---

## 5. Nested If Statements

* You can place if statements inside other if statements.
* Useful for evaluating multiple levels of conditions.

**Example:**

```bash
if [ $1 -gt 100 ]
then
  echo "Large number."
  if (( $1 % 2 == 0 ))
  then
    echo "And it's even."
  fi
fi
```

* Use double parentheses `(( ))` for arithmetic expressions.
* Avoid nesting more than three levels deep; refactor logic instead.

---

## 6. If–Else

* Executes one block if true, another if false.

**Syntax:**

```bash
if [ <test> ]
then
  <commands>
else
  <other commands>
fi
```

**Example:**

```bash
if [ $# -eq 1 ]
then
  nl $1
else
  nl /dev/stdin
fi
```

---

## 7. If–Elif–Else

* Allows multiple conditions to be checked in sequence.

**Syntax:**

```bash
if [ <test> ]
then
  <commands>
elif [ <test> ]
then
  <commands>
else
  <commands>
fi
```

**Example:**

```bash
if [ $1 -ge 18 ]
then
  echo "You may go to the party."
elif [ $2 == "yes" ]
then
  echo "You may go but be back before midnight."
else
  echo "You may not go."
fi
```

---

## 8. Boolean Operations

* Combine conditions with **AND (&&)** and **OR (||)**.

**Examples:**

```bash
# AND example
if [ -r $1 ] && [ -s $1 ]
then
  echo "This file is useful."
fi

# OR example
if [ $USER == 'bob' ] || [ $USER == 'andy' ]
then
  ls -alh
else
  ls
fi
```

---

## 9. Case Statements

* Cleaner alternative to multiple `if/elif` blocks.
* Matches patterns against a variable.

**Syntax:**

```bash
case <variable> in
  <pattern1>)
    <commands>
    ;;
  <pattern2>)
    <commands>
    ;;
  *)
    <default commands>
    ;;
esac
```

**Example:**

```bash
case $1 in
  start)
    echo "starting"
    ;;
  stop)
    echo "stopping"
    ;;
  restart)
    echo "restarting"
    ;;
  *)
    echo "unknown command"
    ;;
esac
```

**Pattern Example (disk usage):**

```bash
space_free=$(df -h | awk '{print $5}' | sort -n | tail -n 1 | sed 's/%//')
case $space_free in
  [1-5]*)
    echo "Plenty of space available."
    ;;
  [6-7]*)
    echo "Potential issue soon."
    ;;
  8*)
    echo "Consider cleaning up files."
    ;;
  9*)
    echo "Critical disk usage!"
    ;;
  *)
    echo "Unexpected value."
    ;;
esac
```

---

## 10. Summary of Key Concepts

* **if** – Run commands if a condition is true.
* **else** – Run alternative commands if the condition is false.
* **elif** – Test another condition if previous was false.
* **&& / ||** – Logical AND / OR for multiple conditions.
* **case** – Simplifies matching patterns or multiple options.
* **Indenting** – Increases readability and helps prevent logic errors.
* **Planning** – Structure scripts before writing to maintain clarity.

---

## 11. Practice Activities

1. Write a script that compares two numbers and prints the larger one.
2. Write a script that checks if a given file is executable or writable and prints messages accordingly.
3. Write a script that prints a message depending on the current day of the week.

---

## 12. Key Takeaways

* Bash `if` statements control decision flow — execute commands only when conditions are true.
* `[ ]` are shorthand for the `test` command; return code `0` = true, `1` = false.
* `-eq`, `-gt`, `-lt` are for numeric comparisons; `=`, `!=` are for strings.
* Always quote variables (`"$VAR"`) to prevent word-splitting or globbing issues.
* Use **indentation** and comments for clarity — essential in larger automation scripts.
* Combine multiple conditions with **&& (AND)** and **|| (OR)** for complex logic.
* Use **case statements** to simplify scripts with multiple pattern checks.
* Test each logical path with different inputs before deployment.

---

## 13. Notes for SOC / Penetration Testers

* **Conditional logic is the backbone of automation.**
  If statements enable decision-based scripting — vital for custom reconnaissance, log analysis, and alerting workflows.

* **For SOC analysts:**

  * Automate detection scripts that trigger only on specific log events or indicators.
  * Use `if` checks to validate log integrity, alert status, or file size before parsing.
  * Combine with cron jobs to monitor changes in `/var/log/` or security event outputs.

* **For Penetration testers:**

  * Build recon scripts that test multiple conditions (e.g., open ports, response codes, accessible directories).
  * Use `if` and `case` to automatically switch payloads or tools depending on system feedback.
  * Check permissions, SUID bits, and execution privileges dynamically before attempting privilege escalation.

* **Professional tip:**
  Write modular scripts where logic branches clearly separate scanning, validation, and reporting phases — this keeps results repeatable and defensible during engagements.

---
