#!/usr/bin/env bash
set -e

function link_directory {
    # make the target directory
    if [ ! -e "${target}" ];
    then
        mkdir $target
    fi

    for f in $1/*
    do
        link_file $f
    done
}

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sfn ${source} ${target}
}

function link_target {
    if [ -d $1 ]
    then
        link_directory $1
    else
        link_file $1
    fi
}

function unlink_directory {
    for f in $1/*
    do
        unlink_file $f
    done
}

function unlink_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    fi
}

function unlink_target {
    if [ -d $1 ]
    then
        unlink_directory $1
    else
        unlink_file $1
    fi
}

case "$1" in
    vim)
        for i in _vim*
        do
           link_target $i
        done
        ;;
    restore)
        for i in _*
        do
            unlink_target $i
        done
        ;;
    *)
        for i in _*
        do
            link_target $i
        done
        ;;
esac
