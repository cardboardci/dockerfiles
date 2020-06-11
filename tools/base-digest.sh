#!/bin/bash
set -e

if [ "$@" == "" ]; then
    echo "A digest must be supplied"
    exit 1
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
DIR_ROOT="$( dirname "${DIR}" )"

echo $@
find "${DIR_ROOT}/images/" -type f -name "Dockerfile" -exec \
    sed -i "/ARG DIGEST=/c\ARG DIGEST=$@" {} +

