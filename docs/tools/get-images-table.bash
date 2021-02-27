#!/bin/bash
set -e

for img in *
do
    if [ "$img" != "base" ]
    then 
        description=$(buildozer 'print labels' "//images/$img:image" | sed 'x;${s/,$//;p;x;};1d' | jq -r '."org.opencontainers.image.description"')
        echo "| [**cardboardci/${img}**](images/${img}) | ${description} |"
    fi
done