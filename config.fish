# add home bin dirs to path
set -x PATH $HOME/bin $HOME/.local/bin $PATH

# set editor
set -x EDITOR '/usr/local/bin/vim'
set -x GIT_EDITOR "$EDITOR"

# set TERM
if test "$TERM" = "xterm" -o "$TERM" = "screen"
    set -x TERM "$TERM-256color"
end

# set pythonrc
set -x PYTHONSTARTUP $HOME/.pythonrc.py

# Theme
powerline-daemon -q
set -x LOCAL_SITE_PKGS "$HOME/.local/lib/python2.7/site-packages"
set fish_function_path $fish_function_path "$LOCAL_SITE_PKGS/powerline/bindings/fish"
powerline-setup

# dircolors
if test -f $HOME/.dir_colors
    eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
end

. $fish_path/custom/plugins/virtualfish/virtual.fish
set -x VIRTUAL_ENV_DISABLE_PROMPT true

# Load /etc/profile.d
for conf in /etc/profile.d/*.fish
    . $conf
end

if which go > /dev/null ^&1
    set -x GOPATH $HOME/go
    set -x PATH $PATH $GOPATH/bin
end

if which git > /dev/null ^&1
    alias gpull 'git pull'
    alias gpush 'git push'
    alias gci 'git commit'
    alias gco 'git checkout'
    alias gst 'git status'
end
