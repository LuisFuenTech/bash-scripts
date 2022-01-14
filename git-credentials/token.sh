#!/bin/bash
### TODO: Check if the remote have username and token added by regex, then validate it
username="$1"
token="$2"
remote=$(git remote -v | grep fetch)
GIT_ERROR=false
ERROR=false
REMOTE_GITHUB_PATTERN='^(https|http):\/\/github\.com\/(.*)\.git$'
REMOTE_GITHUB_TOKEN_PATTERN='^(https|http):\/\/[0-9a-zA-Z_]+:[0-9a-zA-Z_]+@github\.com\/(.*)\.git$'
url=""
protocolHttp=""
githubProject=""

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
values=(${remote/// })
url=${values[1]}

if [[ $url =~ $REMOTE_GITHUB_PATTERN ]]; then
    echo "${BASH_REMATCH[0]}"
    protocolHttp=${BASH_REMATCH[1]}
    githubProject=${BASH_REMATCH[2]}

elif [[ $url =~ $REMOTE_GITHUB_TOKEN_PATTERN ]]; then
    echo "${BASH_REMATCH[0]}"
    protocolHttp=${BASH_REMATCH[1]}
    githubProject=${BASH_REMATCH[2]}
else
    echo "💥 Invalid remote url -> '$url' 💥"
    exit 1
fi

echo "Bulding new origin remote... 🔨"
newOriginRemote="$protocolHttp://$username:$token@github.com/$githubProject.git"

echo "Updating local origin remote... 📝"
git remote set-url origin $newOriginRemote || GIT_ERROR=true
git config --local credential.helper cache || GIT_ERROR=true
checkError

echo "Origin remote updated ✅ -> $newOriginRemote"
exit 0
