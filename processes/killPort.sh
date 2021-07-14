#!/bin/bash
port="$1"

if [ $# -eq 0 ] || [ -z $@ ]; then
    echo "💥 No arguments provided 💥"
    exit 1
fi

echo "🔪 Killing $port process! 🔪"
pid=$(lsof -i:$port -t);

if [ -z $pid ]; then 
	echo "😅 No exists process running in this $port 😅"
	exit 1
fi

kill $pid