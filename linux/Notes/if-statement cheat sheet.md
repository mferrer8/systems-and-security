# 🧠 Bash If Statement Cheat Sheet

## 📘 What It Does
The `if` statement checks **if something is true** — and if it is, Bash will run a specific command or set of commands.

---

## 🧩 Basic Format
```bash
if [ condition ]
then
  commands
fi
````

### Example:

```bash
if [ "$name" == "Marc" ]
then
  echo "Hey Marc!"
fi
```

✅ If the condition is true, it runs the `echo` command.
❌ If not, it skips the `then` section.

---

## ⚖️ Adding Else / Else If

```bash
if [ condition1 ]
then
  commands_if_true
elif [ condition2 ]
then
  commands_if_second_true
else
  commands_if_all_false
fi
```

### Example:

```bash
if [ $age -lt 13 ]
then
  echo "You are a kid."
elif [ $age -lt 18 ]
then
  echo "You are a teenager."
else
  echo "You are an adult."
fi
```

---

## 🔢 Comparison Operators

| Type    | Symbol | Meaning               | Example         |
| ------- | ------ | --------------------- | --------------- |
| Numbers | `-eq`  | equal                 | `[ 5 -eq 5 ]` ✅ |
| Numbers | `-ne`  | not equal             | `[ 5 -ne 3 ]` ✅ |
| Numbers | `-lt`  | less than             | `[ 2 -lt 5 ]` ✅ |
| Numbers | `-le`  | less than or equal    | `[ 5 -le 5 ]` ✅ |
| Numbers | `-gt`  | greater than          | `[ 8 -gt 3 ]` ✅ |
| Numbers | `-ge`  | greater than or equal | `[ 8 -ge 8 ]` ✅ |

---

## 🧵 String Comparison

| Check      | Example            | True When         |
| ---------- | ------------------ | ----------------- |
| Equals     | `[ "$a" == "$b" ]` | both are the same |
| Not equals | `[ "$a" != "$b" ]` | different words   |
| Empty      | `[ -z "$a" ]`      | variable is empty |
| Not empty  | `[ -n "$a" ]`      | variable has text |

---

## 📂 File & Directory Tests

| Flag | True If...                    | Example             |
| ---- | ----------------------------- | ------------------- |
| `-e` | file or directory exists      | `[ -e file.txt ]`   |
| `-f` | file exists (not a directory) | `[ -f notes.md ]`   |
| `-d` | directory exists              | `[ -d /home/user ]` |
| `-r` | readable                      | `[ -r file.txt ]`   |
| `-w` | writable                      | `[ -w file.txt ]`   |
| `-x` | executable                    | `[ -x script.sh ]`  |

---

## 🔗 Logical Operators

| Operator | Meaning                 | Example                           |
| -------- | ----------------------- | --------------------------------- |
| `&&`     | AND — both must be true | `[ $a -gt 2 ] && [ $b -lt 5 ]`    |
| `\|\|`   | OR — one must be true   | `[ $a -gt 5 ] \|\| [ $b -lt 10 ]` |
| `!`      | NOT — reverse result    | `[ ! -f /etc/passwd ]`            |

---

## 🧮 Arithmetic Style If

Another way to test numbers using **(( ... ))**:

```bash
if (( x > 5 )); then
  echo "x is greater than 5"
fi
```

No need for `-lt` / `-gt` here!

---

## 🧰 Command Exit Status

Every Linux command gives an **exit code**:

* `0` means success ✅
* Anything else means error ❌

You can test it like this:

```bash
if ping -c 1 google.com > /dev/null 2>&1
then
  echo "Google is reachable"
else
  echo "Google is down or blocking ping"
fi
```

---

## 🪄 4th-Grade Explanation

Think of `if` like asking a yes/no question:

🧍 “If it’s raining, take an umbrella.”
If that’s true → you grab the umbrella.
If it’s false → you skip that step.

Same idea in Bash:
If something is true → do a thing.
If not → skip it or do something else.

---

## 🧩 Quick Reference

| Structure                                 | Description              |
| ----------------------------------------- | ------------------------ |
| `if [ condition ]; then ... fi`           | Basic if                 |
| `if ...; then ...; else ... fi`           | Add else                 |
| `if ...; then ...; elif ...; else ... fi` | Chain conditions         |
| `[[ ... ]]`                               | Advanced test syntax     |
| `(( ... ))`                               | Math comparison          |
| `!`                                       | NOT (reverse true/false) |

---

## ✅ Key Takeaways

* Always put **spaces inside [ ]** like `[ "$x" -gt 5 ]`.
* Use **quotes** around variables to avoid errors (`"$var"`).
* `-eq`, `-lt`, `-gt` are for **numbers**; `==`, `!=` are for **text**.
* `if command; then` checks if a command **succeeded**.
* Always close the block with `fi`.

---

## 🧠 SOC & Penetration Tester Notes

* Use `if` statements to **automate logic** in scripts (e.g., log only successful scans, skip unreachable hosts).
* Combine `if` with commands like `ping`, `nmap`, `curl`, or `grep` for smart conditions.
* `if [ -f logfile ]` → check before writing.
* `if (( $? != 0 ))` → handle failed commands gracefully.
* You’ll use this constantly in **network sweeps**, **log parsers**, and **automated alert scripts**.

---

### Example: Smart Ping Check

```bash
#!/bin/bash
site="www.google.com"

if ping -c 2 -W 2 "$site" > /dev/null 2>&1
then
  echo "$site is up"
else
  echo "$site is down"
fi
```
