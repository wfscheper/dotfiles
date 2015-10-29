# Path to Oh My Fish install.
set -gx OMF_PATH /Users/wasche/.local/share/omf

# Customize Oh My Fish configuration path.
#set -gx OMF_CONFIG /Users/wasche/.config/omf

# load virtualfish
if test -f $LOCAL_SITE_PKGS/virtualfish/virtual.fish
    eval (python -m virtualfish auto_activation global_requirements)
end

# Load oh-my-fish configuration.
source $OMF_PATH/init.fish
