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

if [ "$1" = "bash" ]; then
    if [ ! -e $HOME/.bash_it ]; then
        git clone https://github.com/revans/bash-it.git $HOME/.bash_it
    fi
    cp -R bash-it-config/* ~/.bash_it/.
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
fi

#git submodule update --init --recursive
#git submodule foreach --recursive git pull origin master

# setup command-t
#cd _vim/bundle/command-t
#rake make

ln -sfn "$(pwd)/ssh_config" ~/.ssh/config

ln -sfn "$(pwd)/config.fish" ~/.config/fish/config.fish

./tmux_setup.sh
