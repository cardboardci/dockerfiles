#!/bin/bash
set -e
CONTAINER="definitions/$@"

# Emit the current versions
echo "Current versions"
cat ${CONTAINER}/provision/nodelist

mv ${CONTAINER}/provision/nodelist ${CONTAINER}/provision/nodelist.bak
touch ${CONTAINER}/provision/nodelist
while read line; do
    echo "Working with ${line}"
    input=(${line//@/ })
    echo "Determining version for ${input}"
    version=$(npm show ${input} version)
    echo "Found version as ${version}"
    echo "${input}@${version}" >> ${CONTAINER}/provision/nodelist
done <${CONTAINER}/provision/nodelist.bak

#
rm ${CONTAINER}/provision/nodelist.bak
cat ${CONTAINER}/provision/nodelist