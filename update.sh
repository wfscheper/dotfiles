#!/usr/bin/env bash

set -e

packages="bash fish git powerline python ssh tmux vim"
if [[ "$(uname)" == Darwin ]]; then
    packages="${packages} iterm"
fi

stow ${packages}