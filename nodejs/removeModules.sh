#!/bin/bash
# Errors variables
ERROR=false

# Node files and directories
PACKAGE_LOCK="package-lock.json"
NODE_MODULES="node_modules"

# Flags
ACTION_FLAG=false

function checkError() {
    if [[ $ERROR == true ]] then
        echo "[Error]: Script couldn't run successfully 💥"
        exit 1
    fi
}

echo "Moving to $PWD... 🚀" 
cd $PWD || ERROR=true
checkError

if [[ -f "$PACKAGE_LOCK" ]]; then
    ACTION_FLAG=true
    echo "Removing '$PACKAGE_LOCK' file...⚙️"
    rm $PACKAGE_LOCK || ERROR=true
    checkError
    
    echo "'$PACKAGE_LOCK' file removed! ✅"
fi

if [[ -d "$NODE_MODULES" ]]; then
    ACTION_FLAG=true
    echo "Removing '$NODE_MODULES' directory...⚙️"
    rm -rf $NODE_MODULES || ERROR=true
    checkError
    
    echo "'$NODE_MODULES' directory removed! ✅"
fi

if [[ $ACTION_FLAG == false ]]; then
    echo "There's nothing to remove! 🗑"
else
    echo "Done! ✅"
fi

exit 1