# load virtualfish
if test -f $LOCAL_SITE_PKGS/virtualfish/virtual.fish
    set -x VIRTUALFISH_COMPAT_ALIASES true
    eval (python -m virtualfish compat_aliases auto_activation global_requirements projects)
end
