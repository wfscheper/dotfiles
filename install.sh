#!/usr/bin/env bash
set -e

OMF_DIR="${HOME}/.local/share/omf"
VUNDLE_DIR="${HOME}/.vim/bundle/Vundle.vim"

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
        if ! [[ -d "${VUNDLE_DIR}" ]]; then
            # clone repo ignoring errors
            git clone https://github.com/VundleVim/Vundle.vim.git \
                "${VUNDLE_DIR}" || true
        fi
        ;;
    restore)
        for i in _*
        do
            unlink_file "$i"
        done
        echo "You may wish to remove ${OMF_DIR} and ${VUNDLE_DIR}"
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
        if ! [[ -d "${OMF_DIR}" ]]; then
            # clone repo ignoring errors
            git clone https://github.com/oh-my-fish/oh-my-fish \
                "${OMF_DIR}" || true
        fi
        if ! [[ -d "${VUNDLE_DIR}" ]]; then
            # clone repo ignoring errors
            git clone https://github.com/VundleVim/Vundle.vim.git \
                "${VUNDLE_DIR}" || true
        fi
        ;;
esac
