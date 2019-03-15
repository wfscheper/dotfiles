# set path
if status is-login;
    # set a basic path
    set -gx PATH /usr/local/bin /usr/bin /usr/local/sbin /usr/sbin

    # add custom paths
    for path in \
            $HOME/bin \
            $HOME/.local/bin \
            $HOME/.local/go/bin \
            $HOME/go/bin \
            $HOME/.pyenv/bin \
            $HOME/.poetry/bin
        test -d $path
        and set -gx PATH $path $PATH
    end
end

# load aliases
source $OMF_CONFIG/aliases.fish

# configure syntax colors
source $OMF_CONFIG/solarized.fish

# configure theme
set -g theme_color_scheme solarized
set -g theme_display_cmd_duration no
set -g theme_display_date no
set -g theme_display_k8s_context no
set -g theme_display_user yes
set -g theme_nerd_fonts yes
set -g theme_newline_cursor yes

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
    which pyenv >/dev/null 2>&1
    and contains $HOME/.pyenv/shims $PATH
    or source (pyenv init - | psub)

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

function fish_title
    echo $USER@(hostname) ' ' $_ ' '
    pwd
end
