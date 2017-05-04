# load aliases
source $OMF_CONFIG/aliases.fish

# configure syntax colors
source $OMF_CONFIG/solarized.fish
set -g theme_color_scheme solarized-light

# tmux updatenv command
source $OMF_CONFIG/tmux.fish

# set TERM
if test "$TERM" = "xterm" -o "$TERM" = "screen"
    set -x TERM "$TERM-256color"
end

# dircolors
if test -f $HOME/.dir_colors
    eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
end

if status --is-interactive
    if test -f $HOME/.pyenv/bin/pyenv
        source (pyenv init - | psub)
    end

    if set -q GPG_TTY
        set __tty (tty)
        if test $GPG_TTY != $__tty
            # reset GPG_TTY
            set -xg GPG_TTY $__tty
        end
        set -e __tty
    else
        set -xg GPG_TTY (tty)
    end
end

if test $TMUX
    set -x SSH_AUTH_SOCK ~/.ssh_auth_sock_(tmux display-message -p '#S')
end
