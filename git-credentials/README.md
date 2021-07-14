# Installation

1. Go to the path `/User/{userName}`
2. Clone this repo
3. Paste this in the `zshrc` or `bashrc` file

   ```
   export SCRIPTS_PATH="/Users/{userName}/Scripts"

   setGitUser(){ sudo sh "${SCRIPTS_PATH}/git-credentials/init.sh" "$1" "$2" "$3" }
   setMyGitUser(){ sudo sh "${SCRIPTS_PATH}/git-credentials/mine.sh" "$1" "$2" }
   ```

4. Reset the terminal with `source .[zshrc|bashrc]`

# Implementation

1. Go to the repo with git initialized
2. Type and enter the in the terminal with the params require (`username, email, mode (global|local)`)

   ```
   setGitUser "luis" "luis@email.com" "local"
   ```
