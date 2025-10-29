# Hello World Bash Script

## Overview
This script displays the message **“Hello World!”** in the terminal.  
It demonstrates the basics of Bash scripting, including file creation, permissions, execution, and adding a **shebang** line to define the script interpreter.

---

## Steps Taken

```bash
# 1️⃣ Create the file and write the echo command into it
echo echo "Hello World\!" > helloWORLD.sh

# 2️⃣ Add execute permissions for the owner and read/execute for the group
chmod 750 helloWORLD.sh

# 3️⃣ Test run the script
./helloWORLD.sh
# Output: Hello World!
````

---

## Adding a Shebang to an Existing Script

The **shebang** (`#!/bin/bash`) tells the system which interpreter to use when executing the script.

You can add it to the top of your existing script in one of two ways:

### Option 1: Using `sed` (in-place editing)

```bash
sed -i '1i #!/bin/bash' helloWORLD.sh
```

This inserts `#!/bin/bash` as the **first line** of the file.

### Option 2: Manually edit the file

```bash
nano helloWORLD.sh
```

Then add the following as the very first line:

```bash
#!/bin/bash
```

Save and exit (`Ctrl + O`, `Enter`, `Ctrl + X`).

---

## Final Script Example

```bash
#!/bin/bash
echo "Hello World!"
```

Run again:

```bash
./helloWORLD.sh
```

**Output:**

```bash
Hello World!
```

---

## Key Takeaways

* The **shebang** (`#!/bin/bash`) ensures your script runs using the Bash interpreter, even if another shell (like `sh` or `zsh`) is the system default.
* The **backslash (`\`)** before `!` prevents Bash from interpreting it as a history expansion command inside double quotes.
* Use `chmod 750` to safely grant only the necessary permissions.
* The command `sed -i '1i #!/bin/bash'` is a powerful way to automate adding headers to existing scripts.

---
