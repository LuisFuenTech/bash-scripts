#!/bin/bash
# Errors variables
ERROR=false
NPM_ERROR=false

# Node files and directories
PACKAGE_LOCK="package-lock.json"
PACKAGE="package.json"
NODE_MODULES="node_modules"

# Commands
ENTRY_COMMAND="$1"
REMOVE_COMMAND="--remove"
REMOVE_SHORT_COMMAND="-r"
INSTALL_COMMAND="--install"
INSTALL_SHORT_COMMAND="-i"

COMMAND_MAN="
Usage: handleModules <command>

Commands:
--remove, -r    remove package-lock and node_modules 
--install, -i   clean dependencies and install them from package.json"

# Flags
ACTION_FLAG=false

function checkError() {
    if [[ $ERROR == true ]]; then
        echo "[Error]: Script couldn't run successfully 💥"
        exit 1
    fi

    if [ $NPM_ERROR == true ]; then
        echo "[npm Error]: We cannot install NPM dependencies 💥"
        exit 1
    fi
}

function removeNpmModules() {
    echo "Init NPM dependencies removing...⏳\n"
    echo "Moving to $PWD... 🚀\n"
    cd $PWD || ERROR=true
    checkError

    if [[ -f "$PACKAGE_LOCK" ]]; then
        ACTION_FLAG=true
        echo "Removing '$PACKAGE_LOCK' file...⚙️"
        rm $PACKAGE_LOCK || ERROR=true
        checkError

        echo "'$PACKAGE_LOCK' file removed! ✅\n"
    fi

    if [[ -d "$NODE_MODULES" ]]; then
        ACTION_FLAG=true
        echo "Removing '$NODE_MODULES' directory...⚙️"
        rm -rf $NODE_MODULES || ERROR=true
        checkError

        echo "'$NODE_MODULES' directory removed! ✅\n"
    fi

    if [[ $ACTION_FLAG == false ]]; then
        echo "There's nothing to remove! 🗑\n"
    else
        echo "NPM dependencies were removed! ✅\n"
    fi

}

function installNpmModules() {
    echo "Init NPM dependencies installing...⏳\n"
    if [[ -f "$PACKAGE" ]]; then
        echo "Installing NPM dependencies...⚙️\n"
        npm i || NPM_ERROR=true
        checkError

        echo "NPM dependencies installed! ✅"
    else
        echo "This directory doesn't have '$PACKAGE' file"
    fi
}

if [[ -z $@ ]] || [[ $# -eq 0 ]]; then
    echo "Empty arguments. $missingParamsMessage"
    echo "$COMMAND_MAN"
    exit 1
fi

if [[ $ENTRY_COMMAND == $REMOVE_COMMAND ]] || [[ $ENTRY_COMMAND == $REMOVE_SHORT_COMMAND ]]; then
    removeNpmModules
elif
    [[ $ENTRY_COMMAND == $INSTALL_COMMAND ]] || [[ $ENTRY_COMMAND == $INSTALL_SHORT_COMMAND ]]
then
    removeNpmModules
    installNpmModules
else

    echo "The command '$ENTRY_COMMAND' isn't correct ❌"
    echo "$COMMAND_MAN"
fi

exit 1