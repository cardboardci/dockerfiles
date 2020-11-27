#!/bin/bash
set -e

if [[ -z "$GITHUB_TOKEN" ]]; then
	echo "Set the GITHUB_TOKEN env variable."
	exit 1
fi

if [ -z "$(git status --porcelain)" ]; then 
	echo "The working directory is clean. Nothing to do."
	exit
fi

# Configure git
git config --global user.name "${GITHUB_ACTOR}"
git config --global user.email "${GITHUB_ACTOR}@users.noreply.github.com"
git config --global http.sslverify false

## Commit changes
action_branch="gh-actions/$(shuf -i 2000-65000 -n 1)$BRANCH"
git checkout -b "${action_branch}"
git add *
git commit -m "$MESSAGE"

## Add authenticated remote
git remote add github "https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git push -u github HEAD

## Create a pull request
hub pull-request -m "${PULL_REQUEST_TITLE}" $PULL_REQUEST_OPTIONS --assign jrbeverly
