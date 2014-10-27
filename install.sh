#!/usr/bin/env bash
set -e

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

case "$1" in
    vim)
        for i in _vim*
        do
           link_file $i
        done
        ;;
    restore)
        for i in _*
        do
            unlink_file $i
        done
        ;;
    *)
        for i in _*
        do
            link_file $i
        done
        ;;
esac
