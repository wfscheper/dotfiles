#!/bin/bash

# Install tmux configuration & scripts
SCRIPT_DIR="$HOME/bin"

# Check to see if specified directory exists
if [ ! -d $SCRIPT_DIR ] ; then
    mkdir -v $SCRIPT_DIR
fi

# Start copying scripts
(
cd scripts
for f in *
do
  ln -sfi $(pwd)/$f $SCRIPT_DIR/
done
)