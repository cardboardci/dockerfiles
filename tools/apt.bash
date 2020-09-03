#!/bin/bash
set -e
if [ "$@" == "base" ]; then
    CONTAINER="base"
else
    CONTAINER="images/$@"
fi

# Emit the current versions
echo "Current versions"
cat ${CONTAINER}/provision/pkglist

mv ${CONTAINER}/provision/pkglist ${CONTAINER}/provision/pkglist.bak
touch ${CONTAINER}/provision/pkglist
while read line; do
    echo "Working with ${line}"
    input=(${line//=/ })
    echo "Determining version for ${input}"
    version=$(apt-cache policy ${input} | grep 'Candidate: ' | awk -F"[ ',]+" '/Candidate:/{print $3}')
    echo "Found version as ${version}"
    echo "${input}=${version}" >> ${CONTAINER}/provision/pkglist
done <${CONTAINER}/provision/pkglist.bak

#
rm ${CONTAINER}/provision/pkglist.bak
cat ${CONTAINER}/provision/pkglist