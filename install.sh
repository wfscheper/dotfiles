#!/usr/bin/env bash
set -e

readonly OMF_DIR="${HOME}/.local/share/omf"
readonly VUNDLE_DIR="${HOME}/.vim/bundle/Vundle.vim"

function link_dir {
    local src="$1"
    local dst="${HOME}/${1/_/.}"

    if [[ ! -d "${dst}" ]]; then
        mkdir -p "${dst}"
    fi
    for i in ${src}/*; do
        if [[ -f "${i}" ]]; then
            link_file "$i"
        else
            link_dir "$i"
        fi
    done
}

function link_file {
    local target="${PWD}/$1"
    local link_name="${HOME}/${1/_/.}"

    if [[ -e "${link_name}" ]] && [[ ! -L "${link_name}" ]]; then
        mv "${link_name}" "${link_name}.df.bak"
    fi

    ln -sfn "${target}" "${link_name}"
}

function unlink_file {
    local target="${PWD}/$1"
    local link_name="${HOME}/${1/_/.}"

    if [[ -e "${link_name}.df.bak" ]] && [[ -L "${link_name}" ]]; then
        unlink "${link_name}"
        mv "${link_name}.df.bak" "${link_name}"
    fi
}

case "$1" in
    vim)
        for i in _vim*
        do
           link_file "$i"
        done
        if [[ ! -d "${VUNDLE_DIR}" ]]; then
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
            if [[ -f "$i" ]]; then
                link_file "$i"
            else
                link_dir "$i"
            fi
        done

        chmod 0600 ~/.ssh/config
        if [[ ! -d "${OMF_DIR}" ]]; then
            # clone repo ignoring errors
            git clone https://github.com/oh-my-fish/oh-my-fish \
                "${OMF_DIR}" || true
        fi
        if [[ ! -d "${VUNDLE_DIR}" ]]; then
            # clone repo ignoring errors
            git clone https://github.com/VundleVim/Vundle.vim.git \
                "${VUNDLE_DIR}" || true
        fi
        ;;
esac
