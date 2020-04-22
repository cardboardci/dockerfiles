#!/bin/bash
set -e

result=$(curl -s https://api.github.com/repos/cli/cli/releases/latest \
    | grep "browser_download_url.*linux_amd64.deb" \
    | cut -d : -f 2,3 \
    | tr -d \")