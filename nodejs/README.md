# Installation

1. Go to the path `/User/{userName}`
2. Clone this repo
3. Paste this in the `zshrc` or `bashrc` file

   ```
   export SCRIPTS_PATH="/Users/{userName}/Scripts"

   handleModules(){ sudo sh "${SCRIPTS_PATH}/nodejs/handleModules.sh" "$1" }
   installModules(){ sudo sh "${SCRIPTS_PATH}/nodejs/installModules.sh.sh" }
   removeModules(){ sudo sh "${SCRIPTS_PATH}/nodejs/removeModules.sh" }
   ```

4. Reset the terminal with `source .[zshrc|bashrc]`

# Implementation

1. Go to the repo with git initialized
2. Type and enter any of the _function name_ in the terminal with the params require:

```bash
$ handleModules --remove[-r,--install,-i]
```

```bash
$ installModules
```

```bash
$ removeModules
```
