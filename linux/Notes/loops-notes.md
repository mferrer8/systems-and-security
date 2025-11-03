# Bash Loops — Study Notes

## 1. Overview
Loops in Bash are used to **automate repetitive tasks** by running a block of commands multiple times — either until a condition changes or for each item in a list.  
They’re essential for scripting tasks like log parsing, network scanning, or batch processing.

There are **five main loop mechanisms** in Bash:

1. `while` — repeat **while** a condition is true  
2. `until` — repeat **until** a condition becomes true  
3. `for` — repeat for each item in a list or range  
4. `select` — create simple user menus  
5. `break` / `continue` — control loop execution flow  

---

## 2. While Loop

### Syntax
```bash
while [ condition ]
do
  commands
done
```

### Example
```bash
#!/bin/bash
counter=1
while [ $counter -le 10 ]
do
  echo $counter
  ((counter++))
done
echo "All done"
```

### Explanation
- Initializes a counter variable  
- Tests `[ $counter -le 10 ]`  
- Executes the block until the condition is **false**  
- Avoid *off-by-one* errors by understanding `-lt` (less than) vs `-le` (less than or equal)

---

## 3. Until Loop

### Syntax
```bash
until [ condition ]
do
  commands
done
```

### Example
```bash
#!/bin/bash
counter=1
until [ $counter -gt 10 ]
do
  echo $counter
  ((counter++))
done
echo "All done"
```

### Key Difference
- `while` loops run **while the test is true**  
- `until` loops run **until the test becomes true**

### Use Case
Choose whichever structure makes your code easier to read.  
Example:  
- “Run **until** the server responds” sounds clearer than  
- “Run **while** the server is not responding.”

---

## 4. For Loop

### Syntax
```bash
for var in list
do
  commands
done
```

### Example — Basic List
```bash
#!/bin/bash
names='Stan Kyle Cartman'
for name in $names
do
  echo $name
done
echo "All done"
```

### Example — Numeric Range
```bash
for value in {1..5}
do
  echo $value
done
```

### Example — Range with Steps
```bash
for value in {10..0..2}
do
  echo $value
done
```

### Alternate Syntax
```bash
for ((num = 1; num <= 5; num++))
do
  echo $num
done
```

### File Processing Example
```bash
for value in $1/*.html
do
  cp $value $1/$(basename -s .html $value).php
done
```

### Notes
- `{1..10}` defines a numeric range (no spaces).  
- You can step up or down using `{start..end..step}`.  
- Useful for iterating over **files, directories, or command outputs**.

---

## 5. Loop Control Statements

### `break`
Stops the loop immediately.
```bash
if [ $used -gt 90 ]; then
  echo "Low disk space" >&2
  break
fi
```

### `continue`
Skips the current iteration and moves to the next.
```bash
if [ ! -r $value ]; then
  echo "$value not readable" >&2
  continue
fi
```

---

## 6. Select Loop (Menus)

### Syntax
```bash
select var in list
do
  commands
done
```

### Example
```bash
#!/bin/bash
names='Kyle Cartman Stan Quit'
PS3='Select character: '

select name in $names
do
  if [ $name == 'Quit' ]; then
    break
  fi
  echo "Hello $name"
done
echo "Bye"
```

### Output
```
1) Kyle     3) Stan
2) Cartman  4) Quit
Select character: 2
Hello Cartman
```

### Notes
- `PS3` changes the prompt shown to the user.  
- `select` is ideal for **interactive scripts**.  
- Loop exits on `break` or `EOF`.

---

## 7. Summary of Loop Commands

| Command | Description |
|----------|--------------|
| `while do done` | Run commands **while** a test is true |
| `until do done` | Run commands **until** a test is true |
| `for do done` | Run commands for each item in a list |
| `break` | Exit the loop immediately |
| `continue` | Skip current iteration and continue next |
| `select do done` | Create a numbered selection menu |

---

## 8. Key Takeaways
- Loops automate repetitive logic and decision-making in scripts.  
- Use **while** for ongoing conditions (e.g., monitoring until success).  
- Use **until** when waiting for something to happen (e.g., system ready).  
- Use **for** for iterating through lists, files, or ranges.  
- **break** ends a loop early; **continue** skips to the next iteration.  
- **select** makes interactive menus easy for user input.  
- Always plan logic flow to prevent infinite loops (`Ctrl+C` exits one).  
- Keep code clean, well-indented, and easy to follow — clarity matters more than cleverness.

---

## 9. Notes for SOC / Penetration Testers
- **SOC Analysts:**
  - Use loops to continuously monitor log files, system resources, or threat feeds.  
  - Combine with `if` conditions to trigger alerts when anomalies appear.  
  - Automate repetitive checks such as disk usage, failed logins, or service status.

- **Penetration Testers:**
  - Automate enumeration: loop over IP ranges, URLs, or wordlists.  
  - Combine `for` loops with tools like `nmap`, `curl`, or `gobuster`.  
  - Use `while` or `until` to retry exploits or payloads until a condition (e.g., reverse shell) is met.  
  - Build recon automation that tests conditions before escalation attempts.  

- **Pro Tip:**  
  Pair loops with conditional logic to create **smart scripts** — ones that make decisions dynamically during an engagement or monitoring session.
