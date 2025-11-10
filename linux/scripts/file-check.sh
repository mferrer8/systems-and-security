### 🧾 **file-check.sh**

```bash
#!/bin/bash
## ==========================================================
##  FILE: file-check.sh
##  PURPOSE: Check if a file exists and tell the user.
##  USAGE EXAMPLES:
##    1️⃣ ./file-check.sh myfile.txt
##        → checks if myfile.txt exists in current folder
##
##    2️⃣ ./file-check.sh
##        → asks you to type a file name manually
## ==========================================================

# If the user gave a file name as an argument, use it.
# Example: ./file-check.sh myfile.txt
if [ -n "$1" ]; then
  filename="$1"
else
  # Otherwise, ask for it interactively
  echo "Enter a file name to check:"
  read filename
fi

# Check if the file exists (-f means it's a regular file)
if [ -f "$filename" ]; then
  echo "✅ Confirmed: '$filename' exists!"
else
  echo "❌ No such file: '$filename'"
fi
```

---

### 🧠 **Breakdown**

| Code                   | What It Means                                                            |
| ---------------------- | ------------------------------------------------------------------------ |
| `#!/bin/bash`          | Says “this is a bash script.”                                            |
| `if [ -n "$1" ]; then` | Checks if you typed something after the script name (like `myfile.txt`). |
| `read filename`        | Lets you type in a name if you didn’t already.                           |
| `[ -f "$filename" ]`   | Asks, “Does this file exist?”                                            |
| `echo`                 | Prints your message to the screen.                                       |

---

### ✅ **How to Use**

```bash
# make it executable
chmod +x file-check.sh

# run it with a file name
./file-check.sh mynotes.txt

# or just run and type it in
./file-check.sh
