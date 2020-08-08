""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#


""""""""""""""""""""""""""""""
" => Shell section
""""""""""""""""""""""""""""""
if exists('$TMUX')
    if has('nvim')
        set termguicolors
    else
        set term=screen-256color
    endif
endif


""""""""""""""""""""""""""""""
" => Twig section
""""""""""""""""""""""""""""""
autocmd BufRead *.twig set syntax=html filetype=html


""""""""""""""""""""""""""""""
" => git commit section
""""""""""""""""""""""""""""""
au FileType gitcommit setl colorcolumn=71
au Filetype gitcommit setl textwidth=72

""""""""""""""""""""""""""""""
" => Go section
""""""""""""""""""""""""""""""
au FileType go setl foldmethod=syntax


""""""""""""""""""""""""""""""
" => YAML section
""""""""""""""""""""""""""""""
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
au FileType yaml setlocal indentkeys-=<:>
