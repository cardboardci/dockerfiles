#!/bin/bash
set -e

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

# if [ -z "$(git status --porcelain)" ]; then 
# 	echo "The working directory is clean. Nothing to do."
# 	exit
# fi

# Emit the current versions
for image in images/*
do
	(
		cd $image
		ls

		# echo "Current versions"
		# cat ${CONTAINER}/provision/nodelist

		# mv ${CONTAINER}/provision/nodelist ${CONTAINER}/provision/nodelist.bak
		# touch ${CONTAINER}/provision/nodelist
		# while read line; do
		# 	echo "Working with ${line}"
		# 	input=(${line//@/ })
		# 	echo "Determining version for ${input}"
		# 	version=$(npm show ${input} version)
		# 	echo "Found version as ${version}"
		# 	echo "${input}@${version}" >> ${CONTAINER}/provision/nodelist
		# done <${CONTAINER}/provision/nodelist.bak

		# #
		# rm ${CONTAINER}/provision/nodelist.bak
		# cat ${CONTAINER}/provision/nodelist
	)
done