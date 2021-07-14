#!/bin/bash
userName="$1"
userEmail="$2"
mode="$3"
emailPattern="^(.+)@(.+)\.(.+)$"
modePattern="^(global|local)$"
missingParamsMessage="Username, email and mode (global|local) are required ❌"
GIT_ERROR=false
ERROR=false

function checkError() {
    if [ $GIT_ERROR == true ] || [ ERROR == true ]; then
        echo "[Error]: Script couldn't run successfully 💥"
        exit 1
    fi
}

if [[ -z $@ ]]; then
    echo "Empty arguments. $missingParamsMessage"
    exit 1
fi

if [ $# -lt 3 ]; then
    echo "Missing arguments. $missingParamsMessage"
    exit 1
elif [ $# -eq 0 ]; then
    echo "No arguments provided. $missingParamsMessage"
    exit 1
fi

if [[ ! $2 =~ $emailPattern ]]; then
    echo "Enter a valid email (****@****.***) ❌"
    exit 1
fi

if [[ ! $3 =~ $modePattern ]]; then
    echo "Enter a valid mode (global|local) ❌"
    exit 1
fi

echo "Moving to $PWD... 🚀"
cd $PWD || ERROR=true
checkError

echo "Setting git credentials in repository $3ly for $userName... 📝"
git config --$3 user.email $userEmail || GIT_ERROR=true
git config --$3 user.name $userName || GIT_ERROR=true
checkError

echo "Done! ✅"
exit 1
