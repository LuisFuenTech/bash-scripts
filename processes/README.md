# Installation

1. Go to the path `/User/{userName}`
2. Clone this repo
3. Paste this in the `zshrc` or `bashrc` file

   ```
   export SCRIPTS_PATH="/Users/{userName}/Scripts"

   killPort(){ sudo sh "${SCRIPTS_PATH}/processes/killPort.sh" "$1" }
   ```

4. Reset the terminal with `source .[zshrc|bashrc]`

# Implementation

1. Go to the repo with git initialized
2. Type and enter the in the terminal with the params require (`port`)

   ```
   killPort 3001
   ```
