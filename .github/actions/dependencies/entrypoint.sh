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

apt-get update -y

# Emit the current versions
for directory in images/*
do
	image=${directory#"images/"}
	(
		echo "Current image: $image"
		
		if [ -f "${directory}/provision/pkglist" ]; then
			bash tools/apt.bash ${image}
		fi

		if [ -f "${directory}/provision/gemlist" ]; then
			bash tools/gem.bash ${image}
		fi

		if [ -f "${directory}/provision/lualist" ]; then
			bash tools/luarocks.bash ${image}
		fi

		if [ -f "${directory}/provision/nodelist" ]; then
			bash tools/npm.bash ${image}
		fi
	)
done