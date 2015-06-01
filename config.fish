# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

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
set -x POWERLINE_ROOT "$HOME/.local/lib/python2.6/site-packages/powerline"
set fish_function_path $fish_function_path "$POWERLINE_ROOT/bindings/fish"
powerline-setup

# dircolors
if test -f $HOME/.dir_colors
    eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
end

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

. $fish_path/custom/plugins/virtualfish/virtual.fish

# Load /etc/profile.d
for conf in /etc/profile.d/*.fish
    . $conf
end

if which go > /dev/null ^&1
    set -x GOPATH $HOME/go
    set -x PATH $PATH $GOPATH/bin
end
