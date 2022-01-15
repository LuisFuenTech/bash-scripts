#!/bin/bash
# Colors
RED="\033[0;31m"
CYAN="\033[0;36m"
GREEN="\033[0;32m"
RESET="\033[0m"

# Errors variables
ERROR=false
NPM_ERROR=false

# Node files and directories
PACKAGE_LOCK="package-lock.json"
PACKAGE="package.json"
NODE_MODULES="node_modules"

# Commands
COMMAND="$1"
OPTION="$2"

COMMAND_MAN="
USAGE: 
    nmgc <COMMAND> [OPTIONS]

COMMAND
    h, help     show general help
    r, remove   remove package-lock and node_modules
    i, install  clean dependencies and install them from package.json  

OPTIONS:
    -f, --force  force the npm installation
"

# Flags
ACTION_FLAG=false
IS_INSTALL_OPTIONAL=false

function printWithColor() {
    TEXT="$1"
    COLOR="$2"
    COLOR_CODE=""

    case $COLOR in
    red) COLOR_CODE=$RED ;;
    cyan) COLOR_CODE=$CYAN ;;
    green) COLOR_CODE=$GREEN ;;
    *) COLOR_CODE=$RESET ;;
    esac

    printf "$COLOR_CODE$TEXT"
}

function checkError() {
    if [[ $ERROR == true ]]; then
        printWithColor "[Error]: Script couldn't run successfully 💥\n" "red"
        exit 1
    fi

    if [ $NPM_ERROR == true ]; then
        printWithColor "[npm Error]: We cannot install NPM dependencies 💥\n" "red"
        exit 1
    fi
}

function removeNpmModules() {
    printWithColor "$(date +"%Y-%m-%d %T") Init NPM dependencies removing...⏳\n" "cyan" && sleep 0.5
    printWithColor "$(date +"%Y-%m-%d %T") Moving to $PWD... 🚀\n" "green" && sleep 0.5
    cd $PWD || ERROR=true
    checkError

    if [[ -f $PACKAGE_LOCK ]]; then
        ACTION_FLAG=true
        printWithColor "$(date +"%Y-%m-%d %T") Removing '$PACKAGE_LOCK' file...⚙️\n" "green" && sleep 0.5
        rm $PACKAGE_LOCK || ERROR=true
        checkError

        printWithColor "$(date +"%Y-%m-%d %T") '$PACKAGE_LOCK' file removed! ✅\n" "green" && sleep 0.5
    fi

    if [[ -d $NODE_MODULES ]]; then
        ACTION_FLAG=true
        printWithColor "$(date +"%Y-%m-%d %T") Removing '$NODE_MODULES' directory...⚙️\n" "green" && sleep 0.5
        rm -rf $NODE_MODULES || ERROR=true
        checkError

        printWithColor "$(date +"%Y-%m-%d %T") '$NODE_MODULES' directory removed! ✅\n" "green" && sleep 0.5
    fi

    if [[ $ACTION_FLAG == false ]]; then
        printWithColor "$(date +"%Y-%m-%d %T") There's nothing to remove! 🗑\n\n" "cyan" && sleep 0.5
    else
        printWithColor "$(date +"%Y-%m-%d %T") NPM dependencies were removed! ✅\n\n" "cyan" && sleep 0.5
    fi

}

function installNpmModules() {
    printWithColor "$(date +"%Y-%m-%d %T") Init NPM dependencies installing...⏳\n" "cyan" && sleep 0.5
    if [[ -f $PACKAGE ]]; then
        printWithColor "$(date +"%Y-%m-%d %T") Installing NPM dependencies...⚙️\n" "green" && sleep 0.5

        if [[ $IS_INSTALL_OPTIONAL == true ]]; then
            npm i $OPTION --save || NPM_ERROR=true
        else
            npm i --save || NPM_ERROR=true
        fi

        checkError

        printWithColor "$(date +"%Y-%m-%d %T") NPM dependencies installed! ✅\n" "cyan" && sleep 0.5
    else
        printWithColor "$(date +"%Y-%m-%d %T") This directory doesn't have '$PACKAGE' file\n" "cyan" && sleep 0.5
    fi
}

if [[ -z $@ ]] || [[ $# -eq 0 ]]; then
    printWithColor "Empty arguments\n" "red"
    printWithColor "$COMMAND_MAN\n" "cyan"
    exit 1
fi

if [[ $COMMAND == "help" ]] || [[ $COMMAND == "h" ]]; then
    printWithColor "$COMMAND_MAN\n" "cyan"
    exit 1
fi

if [[ -n $OPTION ]]; then
    IS_INSTALL_OPTIONAL=true
fi

if [[ $COMMAND == "remove" ]] || [[ $COMMAND == "r" ]]; then
    removeNpmModules
elif
    [[ $COMMAND == "install" ]] || [[ $COMMAND == "i" ]]
then
    removeNpmModules
    installNpmModules
else
    printWithColor "The command '$COMMAND' isn't correct ❌\n" "red"
    printWithColor "$COMMAND_MAN\n" "cyan"
fi

exit 1
