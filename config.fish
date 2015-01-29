# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# add home bin dirs to path
set PATH $HOME/bin $HOME/.local/bin $PATH

# set editor
set EDITOR /usr/local/bin/vim

# set TERM
set TERM xterm-256color

# set pythonrc
set PYTHONSTARTUP $HOME/.pythonrc.py

# Theme
set fish_theme robbyrussell

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

# Load /etc/profile.d
for conf in /etc/profile.d/*.fish
    . $conf
end
