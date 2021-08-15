#!/bin/bash
### TODO: Check if the remote have username and token added by regex, then validate it
username="$1"
token="$2"
remote=$(git remote -v | grep fetch)
GIT_ERROR=false
ERROR=false

function checkError() {
    if [[ $GIT_ERROR == true ]] || [[ ERROR == true ]]; then
        echo "[Error]: Script couldn't run successfully 💥"
        exit 1
    fi
}

if [[ $# -eq 0 ]] || [[ -z $@ ]]; then
    echo "💥 No arguments provided 💥"
    exit 1
fi

echo "Reading local origin remote... 👀"
values=(${remote//})
url=${values[1]}
urlSplitted=(${url/\/\// })

echo "Assembling new origin remote... 🔨"
newOriginRemote="${urlSplitted[0]}//$username:$token@${urlSplitted[1]}"

echo "Updating local origin remote... 📝"
git remo
git remote set-url origin $newOriginRemote || GIT_ERROR=true
git config --local credential.helper cache || GIT_ERROR=true
checkError

echo "Origin remote updated ✅ -> $newOriginRemote"
exit 0