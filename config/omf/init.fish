# configure syntax colors
source $HOME/.config/omf/solarized.fish
set -g theme_color_scheme solarized-light

# tmux updatenv command
source $HOME/.config/omf/tmux.fish

# set TERM
if test "$TERM" = "xterm" -o "$TERM" = "screen"
    set -x TERM "$TERM-256color"
end

# dircolors
if test -f $HOME/.dir_colors
    eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
end

if command -s git > /dev/null ^&1
    alias gpull 'git pull'
    alias gpush 'git push'
    alias gci 'git commit'
    alias gco 'git checkout'
    alias gst 'git status'
end

# load pyenv
if status --is-interactive
    source (pyenv init - | psub)

    if set -q GPG_TTY
        set __tty (tty)
        if test $GPG_TTY != __tty
            # reset GPG_TTY
            set -xg GPG_TTY $__tty
        end
        set -e __tty
    else
        set -xg GPG_TTY (tty)
    end
end
