" install vim-plug if it is missing
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" ensure vim-plug is installed and then load it
call functions#PlugLoad()
call plug#begin('~/.local/share/nvim/plugged/')

" => Load colorscheme
Plug 'lifepillar/vim-solarized8'

" => Lightline {{{
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
let g:lightline = {
  \ 'colorscheme': 'solarized',
  \ 'active': {
  \     'left': [
  \         [ 'mode', 'paste' ],
  \         [ 'gitbranch' ],
  \         [ 'readonly', 'filetype', 'filename' ],
  \     ],
  \     'right': [
  \         [ 'percent' ],
  \         [ 'lineinfo' ],
  \         [ 'fileformat', 'fileencoding' ],
  \         [ 'gitblame', 'currentfunction',  'cocstatus', 'linter_errors', 'linter_warnings' ],
  \     ],
  \ },
  \ 'component_expand': {
  \     'buffers': 'lightline#bufferline#buffers',
  \ },
  \ 'component_function': {
  \     'fileencoding': 'helpers#lightline#fileEncoding',
  \     'fileformat': 'helpers#lightline#fileFormat',
  \     'filename': 'helpers#lightline#fileName',
  \     'filetype': 'helpers#lightline#fileType',
  \     'gitblame': 'helpers#lightline#gitBlame',
  \     'gitbranch': 'helpers#lightline#gitBranch',
  \ },
  \ 'component_type': {
  \     'buffers': 'tabsel',
  \     'linter_errors': 'error',
  \     'linter_warnings': 'warning',
  \     'readonly': 'error',
  \ },
  \ 'tabline': {
  \     'left': [ [ 'buffers' ] ],
  \     'right': [ [ 'close' ] ]
  \ },
  \ 'tab': {
  \     'active': [ 'filename', 'modified' ],
  \     'inactive': [ 'filename', 'modified' ],
  \ },
\ }
set noshowmode  " lightline makes this irrelevant
" }}}

" => general purpose plugins {{{
""""""""""""""""""""""""""""""""
Plug 'tpope/vim-abolish'                " substitute, search, and abbreviate multiple variants of a word
Plug 'tpope/vim-commentary'             " easy commenting motions
Plug 'benmills/vimux'                   " tmux integration for vim
Plug 'editorconfig/editorconfig-vim'    " .editorconfig support
Plug 'sickill/vim-pasta'                " context-aware pasting
" }}}

" => vim-fugitive {{{
"""""""""""""""""""""
Plug 'tpope/vim-fugitive'
Plug 'sodapopcan/vim-twiggy'
Plug 'rbong/vim-flog'
" }}}

" => coc {{{
""""""""""""
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
    \ 'coc-css',
    \ 'coc-diagnostic',
    \ 'coc-eslint',
    \ 'coc-explorer',
    \ 'coc-git',
    \ 'coc-go',
    \ 'coc-json',
    \ 'coc-prettier',
    \ 'coc-sh',
    \ 'coc-tsserver',
    \ 'coc-vimlsp',
    \ 'coc-yaml',
\ ]

" coc-explorer
nmap <silent> <leader>k :CocCommand explorer<cr>

" coc-git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gs <Plug>(coc-git-chunkinfo)
nmap gu :CocCommand git.chunkUndo<cr>

"tab completion
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
" }}}

" => lanuage plugins {{{
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
let g:jsx_ext_required = 0
let g:ale_linters = {
            \   'go': ['gofmt', 'golint', 'go vet', 'golangci-lint'],
            \   'javascript': ['eslint'],
            \   'jsx': ['eslint'],
            \   'python': ['flake8'],
            \}
let g:ale_linter_aliases = {
            \   'jsx': ['css', 'javascript'],
            \}
let g:ale_fixers = {
            \   'graphql': ['prettier'],
            \   'html': ['prettier'],
            \   'javascript': ['prettier', 'eslint'],
            \   'javascript.jsx': ['prettier', 'eslint'],
            \   'json': ['prettier'],
            \   'markdown': ['prettier'],
            \   'python': ['black', 'isort'],
            \   'typescript': ['prettier', 'eslint'],
            \   'yaml': ['prettier'],
            \   '*': ['remove_trailing_lines', 'trim_whitespace'],
            \}
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_linters_explicit = 1
let g:ale_open_list = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" -> go
Plug 'fatih/vim-go', {
            \ 'do': ':GoUpdateBinaries',
            \ 'tag': 'v1.24',
            \}
" use goimorts as autofmt command
let g:go_fmt_command = "goimports"
" }}}
"
" => misc {{{
"""""""""""""

Plug 'ryanoasis/vim-devicons'
Plug 'janko-m/vim-test'
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>
let g:test#strategy = 'dispatch'
let g:test#python#pytest#options = {
    \ 'nearest': '--tb=short -q',
    \ 'file': '--tb=short -q',
    \ 'suite': '--tb=short -q --cov',
    \}
let g:test#java#runner = 'gradletest'
let g:test#java#gradletest#executable = './gradlew test'
let g:test#java#gradletest#file_pattern = '\v^(.*[Ss]pec|[Tt]est.*|.*[Tt]est(s|Case)?)\.(java|groovy)$'
" }}}

call plug#end()

" => Colorscheme {{{
set background=dark
colorscheme solarized8
" }}}
