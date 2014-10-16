#!/usr/bin/env bash
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sfn ${source} ${target}
}

function unlink_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    fi
}

function install_bash_it {
    if [ ! -e $HOME/.bash_it ]; then
        git clone https://github.com/revans/bash-it.git $HOME/.bash_it
    fi
    cp -R bash-it-config/* ~/.bash_it/.
}

function tmux_setup {
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
        source="${PWD}/${f}"
        target="${SCRIPT_DIR}/${f}"
        if [ -e "${target}" ] && [ ! -L "${target}" ]; then
            mv $target $target.df.bak
        fi
        ln -sfn ${source} ${target}
    done
    )
}

if [ "$1" = "bash" ]; then
    install_bash_it
elif [ "$1" = "vim" ]; then
    for i in _vim*
    do
       link_file $i
    done
elif [ "$1" = "restore" ]; then
    for i in _*
    do
        unlink_file $i
    done
    exit
else
    for i in _*
    do
        link_file $i
    done

    install_bash_it
    tmux_setup
    ln -sfn "${PWD}/ssh_config" ~/.ssh/config
    ln -sfn "${PWD}/config.fish" ~/.config/fish/config.fish
fi
