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
		
		bash tools/apt.bash ${image}
	)
done