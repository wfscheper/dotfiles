#!/usr/bin/env bash

set -e

if [[ "$(uname)" == Darwin ]]; then
    brew bundle
fi

bash ./update.sh
