# set aliases
source $HOME/.config/fish/aliases.fish

# do login setup
if status is-login
    # load pyenv
    if command -v pyenv >/dev/null 2>&1
        if echo (pyenv --version) | grep -q '^pyenv 2\.'
            # pyenv 2.0 changed how we run init
            pyenv init --path | source
        else
            pyenv init - | source
        end
    end

    if test (uname -o) = Darwin
        # add brew's python3.8 to end of path
        fish_add_path --path --append /usr/local/opt/python@3.8/bin
    end
end

if status is-interactive
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
        if command -v dircolors >/dev/null 2>&1
            eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
        else if  command -v gdircolors >/dev/null 2>&1
            eval (dircolors -c $HOME/.dir_colors | sed 's/>&\/dev\/null$//')
        end
    end

    function fish_title
        echo $USER@(hostname) ' ' $_ ' '
        pwd
    end
end

if test -f $HOME/.iterm2_shell_integration.fish
    source $HOME/.iterm2_shell_integration.fish
end
