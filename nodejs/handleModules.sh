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
ENTRY_OPTIONAL_COMMAND="$2"
REMOVE_COMMAND="--remove"
REMOVE_SHORT_COMMAND="-r"
INSTALL_COMMAND="--install"
INSTALL_SHORT_COMMAND="-i"
INSTALL_COMMAND="--install"

COMMAND_MAN="
Usage: handleModules <command>

Commands:
--remove, -r    
    remove package-lock and node_modules 
--install, -i   [options]   
    clean dependencies and install them from package.json"

# Flags
ACTION_FLAG=false
IS_INSTALL_OPTIONAL=false

function checkError() {
    if [[ $ERROR == true ]]; then
        echo "\033[0;31m[Error]: Script couldn't run successfully 💥"
        exit 1
    fi

    if [ $NPM_ERROR == true ]; then
        echo "\033[0;31m[npm Error]: We cannot install NPM dependencies 💥"
        exit 1
    fi
}

function removeNpmModules() {
    echo "\033[0;36m$(date +"%Y-%m-%d %T") Init NPM dependencies removing...⏳" && sleep 0.5
    echo "\033[0;32m$(date +"%Y-%m-%d %T") |----->Moving to $PWD... 🚀" && sleep 0.5
    cd $PWD || ERROR=true
    checkError

    if [[ -f $PACKAGE_LOCK ]]; then
        ACTION_FLAG=true
        echo "\033[0;32m$(date +"%Y-%m-%d %T") |----->Removing '$PACKAGE_LOCK' file...⚙️" && sleep 0.5
        rm $PACKAGE_LOCK || ERROR=true
        checkError

        echo "\033[0;32m$(date +"%Y-%m-%d %T") \t|______'$PACKAGE_LOCK' file removed! ✅" && sleep 0.5
    fi

    if [[ -d $NODE_MODULES ]]; then
        ACTION_FLAG=true
        echo "\033[0;32m$(date +"%Y-%m-%d %T") |----->Removing '$NODE_MODULES' directory...⚙️" && sleep 0.5
        rm -rf $NODE_MODULES || ERROR=true
        checkError

        echo "\033[0;32m$(date +"%Y-%m-%d %T") \t|______'$NODE_MODULES' directory removed! ✅" && sleep 0.5
    fi

    if [[ $ACTION_FLAG == false ]]; then
        echo "\033[0;36m\n$(date +"%Y-%m-%d %T") There's nothing to remove! 🗑\n" && sleep 0.5
    else
        echo "\033[0;36m$(date +"%Y-%m-%d %T") NPM dependencies were removed! ✅\n" && sleep 0.5
    fi

}

function installNpmModules() {
    echo "\033[0;36m$(date +"%Y-%m-%d %T") Init NPM dependencies installing...⏳" && sleep 0.5
    if [[ -f $PACKAGE ]]; then
        echo "\033[0;32m$(date +"%Y-%m-%d %T") |----->Installing NPM dependencies...⚙️" && sleep 0.5

        if [[ $IS_INSTALL_OPTIONAL == true ]]; then
            npm i $ENTRY_OPTIONAL_COMMAND || NPM_ERROR=true
        else
            npm i || NPM_ERROR=true
        fi

        checkError

        echo "\033[0;36m$(date +"%Y-%m-%d %T") NPM dependencies installed! ✅" && sleep 0.5
    else
        echo "\033[0;36m$(date +"%Y-%m-%d %T") This directory doesn't have '$PACKAGE' file" && sleep 0.5
    fi
}

if [[ -z $@ ]] || [[ $# -eq 0 ]]; then
    echo "\033[0;31m$(date +"%Y-%m-%d %T") Empty arguments"
    echo "\033[0;36m$(date +"%Y-%m-%d %T") $COMMAND_MAN"
    exit 1
fi

if [[ -n $ENTRY_OPTIONAL_COMMAND ]]; then
    IS_INSTALL_OPTIONAL=true
fi

if [[ $ENTRY_COMMAND == $REMOVE_COMMAND ]] || [[ $ENTRY_COMMAND == $REMOVE_SHORT_COMMAND ]]; then
    removeNpmModules
elif
    [[ $ENTRY_COMMAND == $INSTALL_COMMAND ]] || [[ $ENTRY_COMMAND == $INSTALL_SHORT_COMMAND ]]
then
    removeNpmModules
    installNpmModules
else
    echo "\033[0;31m$(date +"%Y-%m-%d %T") The command '$ENTRY_COMMAND' isn't correct ❌"
    echo "\033[0;36m$(date +"%Y-%m-%d %T") $COMMAND_MAN"
fi

exit 1
