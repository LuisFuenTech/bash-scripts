#!/bin/bash
USERNAME="$1"
EMAIL="$2"
SCOPE="$3"
emailPattern="^(.+)@(.+)\.(.+)$"
modePattern="^(global|local)$"
missingParamsMessage="Username, email and mode (global|local) are required ❌"
GIT_ERROR=false
ERROR=false

# Commands
COMMAND="$1"

COMMAND_MAN="
USAGE: 
    $ mgc <COMMAND> [<OPTION>] [<ARGUMENT>]

COMMAND
    help     shows general help
    remove   removes git credentials
    save     saves git credentials in the repo
    show     shows git credentials in the repo

OPTION:
    -u <user>, --user=<user>      github username
    -e <email>, --email=<email>   github email
    -s <scope>, --scope=<mode>    scope for git credentials 

ARGUMENT
    user   github username
    email  github email
    scope  git scope (local|global) 
"

function checkError() {
    if [ $GIT_ERROR == true ] || [ ERROR == true ]; then
        echo "[Error]: Script couldn't run successfully 💥"
        exit 1
    fi
}

if [[ -z $@ ]] || [[ $# -eq 0 ]]; then
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

echo "Setting git credentials in repository ${SCOPE}ly for $USERNAME... 📝"
git config --$SCOPE user.email $EMAIL || GIT_ERROR=true
git config --$SCOPE user.name $USERNAME || GIT_ERROR=true
checkError

echo "Done! ✅"
exit 1
