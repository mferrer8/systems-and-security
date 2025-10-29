#!/bin/bash
# ──────────────────────────────────────────────
# Script Name: helloVAR.sh
# Author: Marc Ferrer
# Purpose: Simple interactive Bash script that greets the user by name.
# Location: linux/scripts/helloVAR.sh
# ──────────────────────────────────────────────

# Prompt the user to enter their name.
# The `echo` command prints text to the terminal.
echo "Enter your name:"

# `read` is a built-in Bash command that waits for user input.
# Whatever the user types will be stored in the variable NAME.
read NAME

# `echo` again prints output to the terminal.
# `$NAME` retrieves (expands) the value stored inside the NAME variable.
echo "Hello, $NAME! Welcome to Bash scripting."

# ──────────────────────────────────────────────
# 🔍 EXPLANATIONS AND PRO TIPS
# ──────────────────────────────────────────────
# 1. The first line `#!/bin/bash` is called a *shebang*.
#    It tells the system to run this file using the Bash shell located at /bin/bash.
#
# 2. Variables in Bash are created by assigning a value with `=`.
#      Example: NAME="Marc"
#    - ❗ No spaces allowed around `=` or it will cause an error.
#
# 3. To access the value of a variable, use `$VARIABLE_NAME`.
#      Example: echo $NAME
#
# 4. `read` is used for user input. Syntax:
#      read VARIABLE
#    When run, Bash pauses for input and saves it to the variable.
#
# 5. You can combine text and variable values in echo statements:
#      echo "Hello, $NAME"
#    - Double quotes (" ") allow variable expansion.
#    - Single quotes (' ') treat everything literally (no variable expansion).
#
# 6. Permissions:
#      chmod +x helloVAR.sh   → make the file executable
#      ./helloVAR.sh          → run the script
#
# ──────────────────────────────────────────────
# ⚙️ ADVANCED: COMMAND-LINE ARGUMENTS
# ──────────────────────────────────────────────
# You can modify this script to accept a name as an argument instead of typing it:
#
#   #!/bin/bash
#   NAME=${1:-"World"}
#   echo "Hello, $NAME!"
#
# ──────────────────────────────────────────────
# 💡 SYNTAX BREAKDOWN: ${1:-"World"}
# ──────────────────────────────────────────────
#   ${1:-"World"} means:
#     - `${...}` is a *parameter expansion* in Bash.
#     - `1` refers to the first argument passed to the script (`$1`).
#     - `:-` is a *default value operator* that says:
#         "If the variable is unset or empty, use the value after the colon."
#     - `"World"` is the default value.
#
#   So if you run:
#       ./helloVAR.sh Marc     → Output: Hello, Marc!
#       ./helloVAR.sh          → Output: Hello, World!
#
# ──────────────────────────────────────────────
# ✅ KEY TAKEAWAYS
# ──────────────────────────────────────────────
# • Always include a shebang (#!/bin/bash) at the top of your scripts.
# • Use variables to make scripts flexible and reusable.
# • `read` lets you gather user input interactively.
# • `${variable:-default}` provides safe fallbacks for missing input.
# • Quote your variables ("$NAME") to handle spaces safely.
# • Keep your scripts organized in linux/scripts/ for easy portfolio management.
