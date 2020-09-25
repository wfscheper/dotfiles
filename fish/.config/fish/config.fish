# check for fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME $HOME/.config
    test -f $HOME/.local/src/fisher/fisher.fish
    and ln -s $HOME/.local/src/fisher/fisher.fish $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

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
    test -f $HOME/.dir_colors
    and eval (gdircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
end

# load pyenv
which pyenv >/dev/null 2>&1
and contains $HOME/.pyenv/shims $PATH
or source (pyenv init - | psub)
and source (pyenv virtualenv-init - | psub)

# set vim runtime
set -gx plugin_vundle_runtimepath $HOME/.vim_runtime

function fish_title
    echo $USER@(hostname) ' ' $_ ' '
    pwd
end

test -f $HOME/.iterm2_shell_integration.fish
and source $HOME/.iterm2_shell_integration.fish
