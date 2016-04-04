# configure syntax colors
source $HOME/.config/omf/solarized.fish

# tmux updatenv command
source $HOME/.config/omf/tmux.fish

# set TERM
if test "$TERM" = "xterm" -o "$TERM" = "screen"
    set -x TERM "$TERM-256color"
end

# Theme
powerline-daemon -q
set fish_function_path $fish_function_path "$LOCAL_SITE_PKGS/powerline/bindings/fish"
powerline-setup

# dircolors
if test -f $HOME/.dir_colors
    eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
end

if which git > /dev/null ^&1
    alias gpull 'git pull'
    alias gpush 'git push'
    alias gci 'git commit'
    alias gco 'git checkout'
    alias gst 'git status'
end

# load pyenv
if status --is-interactive
    # load pyenv
    source (pyenv init -|psub)
end
