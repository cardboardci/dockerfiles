#!/bin/bash
set -e
if [ "$@" == "base" ]; then
    CONTAINER="base"
else
    CONTAINER="images/$@"
fi

# Emit the current versions
echo "Current versions"
cat ${CONTAINER}/provision/gemlist

mv ${CONTAINER}/provision/gemlist ${CONTAINER}/provision/gemlist.bak
touch ${CONTAINER}/provision/gemlist
while read line; do
    echo "Working with ${line}"
    input=(${line//:/ })
    echo "Determining version for ${input}"
    version=$(gem list "^${input}$" -r | grep -o '\((.*)\)$' | tr -d '() ' | tr ',' "\n")
    echo "Found version as ${version}"
    echo "${input}:${version}" >> ${CONTAINER}/provision/gemlist
done <${CONTAINER}/provision/gemlist.bak

#
rm ${CONTAINER}/provision/gemlist.bak
cat ${CONTAINER}/provision/gemlist