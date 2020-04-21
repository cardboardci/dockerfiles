#!/bin/bash
set -e
CONTAINER="images/$@"

apt update -qq
apt install -qq luarocks -y

# Emit the current versions
echo "Current versions"
cat ${CONTAINER}/provision/lualist

mv ${CONTAINER}/provision/lualist ${CONTAINER}/provision/lualist.bak
touch ${CONTAINER}/provision/lualist
while read line; do
    echo "Working with ${line}"
    input=(${line// / })
    echo "Determining version for ${input}"
    luarocks install "${input}"
    version=$(luarocks show ${input} | egrep "${input} ([0-9]{1,}\.)+[0-9]{1,}" | awk -F' ' '{print $2}')
    echo "Found version as ${version}"
    echo "${input} ${version}" >> ${CONTAINER}/provision/lualist
done <${CONTAINER}/provision/lualist.bak

#
rm ${CONTAINER}/provision/lualist.bak
cat ${CONTAINER}/provision/lualist