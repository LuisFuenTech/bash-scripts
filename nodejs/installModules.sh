#!/bin/bash
# Errors variables
ERROR=false
NPM_ERROR=false

# Node files and directories
PACKAGE_LOCK="package-lock.json"
PACKAGE="package.json"
NODE_MODULES="node_modules"

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

if [[ -f "$PACKAGE" ]]; then
    echo "Installing NPM dependencies...⚙️\n"
    npm i || NPM_ERROR=true
    checkError

    echo "NPM dependencies installed! ✅"
else
    echo "This directory doesn't have '$PACKAGE' file"
fi

exit 1
