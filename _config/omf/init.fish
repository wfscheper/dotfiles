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

if status --is-interactive
    source (pyenv init - | psub)

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
