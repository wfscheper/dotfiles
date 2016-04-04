# set universal variables if they aren't set
if not set -qU fish_user_paths
    set -U fish_user_paths ~/.local/bin ~/bin
    echo "fish_user_paths set to $fish_user_paths"
end

if not set -qU EDITOR
    set -xU EDITOR (which vim)
    echo "EDITOR set to $EDITOR"
    set -xU GIT_EDITOR $EDITOR
    echo "GIT_EDITOR set to $GIT_EDITOR"
end

if not set -qU LOCAL_SITE_PKGS
    if test -d  ~/.local/lib/python2.7/site-packages
        set -xU LOCAL_SITE_PKGS ~/.local/lib/python2.7/site-packages
        echo "LOCAL_SITE_PKGS set to $LOCAL_SITE_PKGS"
    end
end

if not set -qU PYTHONSTARTUP
    set -xU PYTHONSTARTUP ~/.pythonrc.py
    echo "PYTHONSTARTUP set to $PYTHONSTARTUP"
end

if not set -qU Z_SCRIPT_PATH
    if test -d ~/.zbin
        set -U Z_SCRIPT_PATH ~/.zbin/z.sh
        echo "Z_SCRIPT_PATH set to $Z_SCRIPT_PATH"
    end
end

if not set -qU GOPATH
    if test -d ~/go
        set -xU GOPATH ~/go
        echo "GOPATH set to $GOPATH"
        set -U fish_user_paths $fish_user_paths $GOPATH/bin
        echo "fish_user_paths set to $fish_user_paths"
    end
end

if not set -qU PYENV_ROOT
    if test -d ~/.pyenv
        set -xU PYENV_ROOT ~/.pyenv
        echo "PYENV_ROOT set to $PYENV_ROOT"
        set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths
        echo "fish_user_paths set to $fish_user_paths"
    end
end

# Path to Oh My Fish install.
set -gx OMF_PATH $HOME/.local/share/omf

# Customize Oh My Fish configuration path.
set -gx OMF_CONFIG $HOME/.config/omf

# load virtualfish
if test -f $LOCAL_SITE_PKGS/virtualfish/virtual.fish
    set -x VIRTUALFISH_COMPAT_ALIASES true
    eval (python -m virtualfish compat_aliases auto_activation global_requirements projects)
end

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
