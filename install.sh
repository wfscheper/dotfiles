#!/usr/bin/env bash
set -e

function install_repo {
    local repository="$1"
    local directory="$2"
    local name=
    local response=

    name="${repository##*/}"
    name="${name%%.git}"

    read -p "Install ${name}? [y/N] " response
    if [[ "${response}" =~ ^[yY]([eE][sS])?$ ]]; then
        git clone --recursive "${repository}" "${directory}" 2>/dev/null || true
    fi
}

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
        [[ -e "${HOME}/.vim/bundle/Vundle.vim" ]] || install_repo https://github.com/VundleVim/Vundle.vim.git \
            "${HOME}/.vim/bundle/Vundle.vim"
        ;;
    restore)
        for i in _*
        do
            unlink_file "$i"
        done
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
        [[ -e "${HOME}/.local/share/omf" ]] || install_repo https://github.com/oh-my-fish/oh-my-fish \
            "${HOME}/.local/share/omf"
        [[ -e "${HOME}/.vim/bundle/Vundle.vim" ]] || install_repo https://github.com/VundleVim/Vundle.vim.git \
            "${HOME}/.vim/bundle/Vundle.vim"
        [[ -e "${HOME}/.bash_it" ]] || install_repo https://github.com/Bash-it/bash-it.git "${HOME}/.bash_it"
        [[ -e "${HOME}/.pyenv" ]] || install_repo https://github.com/yyuu/pyenv.git "${HOME}/.pyenv"
        [[ -e "${HOME}/.zbin" ]] || install_repo https://github.com/rupa/z "${HOME}/.zbin"
        ;;
esac
