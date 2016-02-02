#!/usr/bin/env bash
set -e

function link_file {
    source="${PWD}/$1"
    if [[ -n "$2" ]]; then
        target="${HOME}/$2"
    else
        target="${HOME}/${1/_/.}"
    fi

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv "${target}" "${target}.df.bak"
    fi

    ln -sfn "${source}" "${target}"
}

function unlink_file {
    source="${PWD}/$1"
    if [[ -n "$2" ]]; then
        target="${HOME}/$2"
    else
        target="${HOME}/${1/_/.}"
    fi

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink "${target}"
        mv "${target}.df.bak" "${target}"
    fi
}

case "$1" in
    vim)
        for i in _vim*
        do
           link_file "$i"
        done
        ;;
    restore)
        for i in _*
        do
            unlink_file "$i"
        done
        rm -rf "${HOME}/.local/share/omf"
        ;;
    *)
        for i in _*
        do
            link_file "$i"
        done

        # install .config dirs
        for i in config/*; do
            link_file "$i" ".$i"
        done
        link_file ssh/config .ssh/config
        chmod 0600 ~/.ssh/config
        if ! [[ -d "${HOME}/.local/share/omf" ]]; then
            # clone repo ignoring errors
            git clone https://github.com/oh-my-fish/oh-my-fish \
                "${HOME}/.local/share/omf" || true
        fi
        ;;
esac
