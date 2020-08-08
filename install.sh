#!/usr/bin/env bash

set -e

if [[ "$(uanme)" == Darwin ]]; then
    brew bundle
fi

bash ./update.sh
