# Path to your oh-my-fish.
set fish_path $HOME/.oh-my-fish

# set path
set PATH $HOME/bin $HOME/.local/bin $PATH

# set editor
set EDITOR /bin/vim

# Theme
set fish_function_path $fish_function_path "$HOME/.dotfiles/powerline_bindings/fish"
powerline-setup

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-fish/plugins/*)
# Custom plugins may be added to ~/.oh-my-fish/custom/plugins/
# Example format: set fish_plugins autojump bundler
set fish_plugins pyenv virtualfish jump

# Path to your custom folder (default path is $FISH/custom)
#set fish_custom $HOME/dotfiles/oh-my-fish

# Load oh-my-fish configuration.
. $fish_path/oh-my-fish.fish

eval (dircolors -c "$HOME/.dircolors")

# PYTHONSTARTUP
set -x PYTHONSTARTUP "$HOME/.pythonrc.py"

# add virtualfish
set -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"

. $fish_custom/plugins/virtualfish/virtual.fish
. $fish_custom/plugins/virtualfish/auto_activation.fish
. $fish_custom/plugins/virtualfish/global_requirements.fish
