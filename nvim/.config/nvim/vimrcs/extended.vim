"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer:
"       Walter Scheper
"
"       Based on vimrc by:
"           Amir Salihefendic
"           http://amix.dk - amix@amix.dk
"
" Changelog:
"       2020/10/03 - created
"
" Sections:
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" => GUI related {{{
""""""""""""""""""""

" Set font according to system
if has("mac") || has("macunix")
    set guifont=Hack:h14,Source\ Code\ Pro:h15,Menlo:h15
elseif has("win16") || has("win32")
    set guifont=Hack:h14,Source\ Code\ Pro:h12,Bitstream\ Vera\ Sans\ Mono:h11
elseif has("gui_gtk2")
    set guifont=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("linux")
    set guifont=Hack\ 14,Source\ Code\ Pro\ 12,Bitstream\ Vera\ Sans\ Mono\ 11
elseif has("unix")
    set guifont=Monospace\ 11
endif

" Disable scrollbars
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
" }}}


" => Fast editing and reloading of vimrc configs {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""
" reload entire vim config
map <leader>r :so $MYVIMRC<cr>
" }}}


" => Turn persistent undo on {{{
"    means that you can undo even when you close a buffer/VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
    set undofile
catch
endtry
" }}}


" => Command mode related {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

cnoremap <C-P> <Up>
cnoremap <C-N> <Down>
" }}}
