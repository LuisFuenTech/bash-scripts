#!/bin/bash
PERSONAL_NAME="luisfuentech"
PERSONAL_EMAIL="luisfuentes.au@gmail.com"
CONDOR_NAME="luisfuentesau"
CONDOR_EMAIL="lfuentes@condorlabs.io"
name=""
email=""
credentialType="$1"
mode="$2"
credentialPattern="^(self|dev)$"
modePattern="^(global|local)$"
missingParamsMessage="Type (self|dev) and mode (global|local) are required ❌"
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
    exit
fi

if [ $# -lt 2 ]; then
    echo "Missing arguments. $missingParamsMessage"
    exit 1
    elif [ $# -eq 0 ]; then
    echo "No arguments provided. $missingParamsMessage"
    exit 1
fi

if [[ ! $1 =~ $credentialPattern ]]; then
    echo "Enter a valid type (self|dev) ❌"
    exit 1
fi

if [[ ! $2 =~ $modePattern ]]; then
    echo "Enter a valid mode (global|local) ❌"
    exit 1
fi

case $credentialType in
    "self")
        name=$PERSONAL_NAME
        email=$PERSONAL_EMAIL
    ;;
    "dev")
        name=$CONDOR_NAME
        email=$CONDOR_EMAIL
    ;;
esac

echo "Moving to $PWD... 🚀"
cd $PWD || ERROR=true
checkError

echo "Setting git credentials in repository ${mode}ly for $name... 📝"
git config --${mode} user.email $email || GIT_ERROR=true
git config --${mode} user.name $name || GIT_ERROR=true
checkError

echo "Done! ✅"
exit 1
