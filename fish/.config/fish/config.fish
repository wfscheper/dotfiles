# set aliases
source $HOME/.config/fish/aliases.fish

if status is-login
    # configure bobthefish
    set -g theme_color_scheme solarized
    set -g theme_display_cmd_duration no
    set -g theme_display_date no
    set -g theme_display_k8s_context no
    set -g theme_display_user yes
    set -g theme_nerd_fonts yes
    set -g theme_newline_cursor yes

    # set color scheme
    source $HOME/.config/fish/solarized.fish

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

    # set TERM
    test "$TERM" = "xterm" -o "$TERM" = "screen"
    and set -x TERM "$TERM-256color"

    # dircolors
    if test -f $HOME/.dir_colors
        if command -v dircolors &>/dev/null
            eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
        else if  command -v gdircolors &>/dev/null
            eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
        end
    end
end

# load pyenv
if command -v pyenv &>/dev/null
    source (pyenv init - | psub)
    source (pyenv virtualenv-init - | psub)
end

function fish_title
    echo $USER@(hostname) ' ' $_ ' '
    pwd
end

test -f $HOME/.iterm2_shell_integration.fish
and source $HOME/.iterm2_shell_integration.fish
