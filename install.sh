#!/bin/bash

set -eu

# install deps
if [[ "$OSTYPE" == "darwin"* ]]; then
    pushd macos || exit
    brew bundle
    popd || exit
elif command -v dnf &>/dev/null; then
    xargs -a redhat/packages.txt sudo dnf install -y
elif command -v apt-get &>dev/null; then
    sudo apt-get update
    xargs -a ubuntu/packages.txt sudo apt-get install -y
fi

"$(dirname $0)"/update.sh "$@"
