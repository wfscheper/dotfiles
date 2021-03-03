#!/usr/bin/env bash

set -eu

packages="fish git nvim powerline python ssh tmux vim"
if [[ "$OSTYPE" == "darwin" ]]; then
    packages="${packages} iterm"
fi

stow ${packages} "$@"
