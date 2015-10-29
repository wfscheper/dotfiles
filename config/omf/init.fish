# configure syntax colors
source $HOME/.config/fish/solarized.fish

# add home bin dirs to path
set -x PATH $HOME/bin $HOME/.local/bin /usr/local/opt/coreutils/libexec/gnubin \
    $HOME/.gem/ruby/2.0.0/bin $PATH

# setup homebrew manpath
set -x MANPATH /usr/local/opt/coreutils/libexec/gnuman /usr/local/share/man \
    /usr/share/man

# set editor
set -x EDITOR '/usr/local/bin/vim'
set -x GIT_EDITOR "$EDITOR"

# set TERM
if test "$TERM" = "xterm" -o "$TERM" = "screen"
    set -x TERM "$TERM-256color"
end

# set pythonrc
set -x PYTHONSTARTUP $HOME/.pythonrc.py

set -x LOCAL_SITE_PKGS "/usr/local/lib/python2.7/site-packages"

# Theme
powerline-daemon -q
set fish_function_path $fish_function_path "$LOCAL_SITE_PKGS/powerline/bindings/fish"
powerline-setup

# dircolors
if test -f $HOME/.dir_colors
    eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
end

# Load /etc/profile.d
for conf in /etc/profile.d/*.fish
    source $conf
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

# load pyenv
if test -d $HOME/.pyenv
    set PYENV_ROOT $HOME/.pyenv
    set -x PATH $PYENV_ROOT/bin $PATH
    status --is-interactive; and . (pyenv init -|psub)
end
