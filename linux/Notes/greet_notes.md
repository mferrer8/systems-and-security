# greet.sh — Argument Handling, Sorting, and Reversing

**Objective:**  
Create a Bash script that greets multiple users, sorts their names alphabetically, and then displays them in reverse order.

---

## 🧩 Script Code

```bash
#!/bin/bash
set -euo pipefail
# greet.sh — Handle arguments, sort alphabetically, and reverse order

if [ $# -eq 0 ]; then
    echo "Usage: $0 <name1> [name2] ..."
    echo "Example: $0 Marc Alice Bob"
    exit 1
fi

# Capture all arguments as a list
names=("$@")

# Sort names alphabetically using 'sort'
sorted_names=$(printf "%s\n" "${names[@]}" | sort)

echo "=== Alphabetical Order ==="
while read -r name; do
    echo "Hello, $name!"
done <<< "$sorted_names"

# Reverse the order using 'tac'
reversed_names=$(printf "%s\n" "${names[@]}" | sort | tac)

echo
echo "=== Reverse Order ==="
while read -r name; do
    echo "Hello, $name!"
done <<< "$reversed_names"
````

---

## ⚙️ Commands Used

| Command                                      | Description                                                                         |
| -------------------------------------------- | ----------------------------------------------------------------------------------- |
| `set -euo pipefail`                          | Enables safer script execution (stop on errors, undefined vars, and pipe failures). |
| `"$@"`                                       | Refers to all command-line arguments passed to the script.                          |
| `sort`                                       | Alphabetically sorts lines of text.                                                 |
| `tac`                                        | Outputs lines in reverse order.                                                     |
| `printf "%s\n"`                              | Prints each argument on its own line for sorting.                                   |
| `while read -r name; do ... done <<< "$var"` | Reads each line of a variable as input.                                             |
| `chmod +x greet.sh`                          | Makes the script executable.                                                        |
| `./greet.sh Marc Alice Bob`                  | Runs the script with three arguments.                                               |

---

## 🧠 Example Output

```bash
$ ./greet.sh marc alice john

=== Alphabetical Order ===
Hello, alice!
Hello, john!
Hello, marc!

=== Reverse Order ===
Hello, marc!
Hello, john!
Hello, alice!
```

---

## 🧰 Notes & Pro Tips

* `sort -r` can replace `tac` for direct reverse sorting.
* Add `sort -f` to make sorting case-insensitive.
* Use `> sorted.txt` to save results to a file.
* `$#` checks how many arguments were given (useful for validation).

---

## 🧩 Key Takeaways

* Bash scripts can accept multiple inputs using `$@` and `$#`.
* Sorting and reversing can be done efficiently with `sort` and `tac`.
* Always validate arguments for safer automation.
* Use `set -euo pipefail` in all scripts to enforce professional scripting standards.

---
