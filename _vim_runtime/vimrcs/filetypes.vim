""""""""""""""""""""""""""""""
" => Python section
""""""""""""""""""""""""""""""
let python_highlight_all = 1
au FileType python syn keyword pythonDecorator True None False self

au BufNewFile,BufRead *.jinja set syntax=htmljinja
au BufNewFile,BufRead *.mako set ft=mako

" au FileType python inoremap <buffer> $r return 
" au FileType python inoremap <buffer> $i import 
" au FileType python inoremap <buffer> $p print 
" au FileType python inoremap <buffer> $f #--- <esc>a
" au FileType python map <buffer> <leader>1 /class 
" au FileType python map <buffer> <leader>2 /def 
" au FileType python map <buffer> <leader>C ?class 
" au FileType python map <buffer> <leader>D ?def 
au FileType python set cindent
au FileType python set cinkeys-=0#
au FileType python set indentkeys-=0#


""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent
au FileType javascript setl tabstop=2
au FileType javascript setl shiftwidth=2
au FileType javascript setl softtabstop=2

au FileType javascript imap <c-t> $log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

" au FileType javascript inoremap <buffer> $r return 
" au FileType javascript inoremap <buffer> $f //--- PH<esc>FP2xi

function! JavaScriptFold() 
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
        return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => CoffeeScript section
"""""""""""""""""""""""""""""""
function! CoffeeScriptFold()
    setl foldmethod=indent
    setl foldlevelstart=1
endfunction
au FileType coffee call CoffeeScriptFold()

au FileType gitcommit call setpos('.', [0, 1, 1, 0])


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
