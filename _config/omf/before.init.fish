# load virtualfish
if test -f $LOCAL_SITE_PKGS/virtualfish/virtual.fish
    set -x VIRTUALFISH_COMPAT_ALIASES true
    eval (command python3 -m virtualfish compat_aliases auto_activation global_requirements projects)
end

# set vim runtime
set -gx plugin_vundle_runtimepath $HOME/.vim_runtime
