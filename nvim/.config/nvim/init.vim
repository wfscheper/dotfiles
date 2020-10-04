" load basic configuration
source ~/.config/nvim/vimrcs/basic.vim

if !exists('g:vscode')
    " load extra config
    source ~/.config/nvim/vimrcs/extended.vim
    source ~/.config/nvim/vimrcs/plugins_config.vim
endif
