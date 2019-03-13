"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if &compatible
  set nocompatible               " Be iMproved
endif
filetype off
set runtimepath+=~/.vim_runtime/bundle/Vundle.vim

" Required:
call vundle#begin('~/.vim_runtime/bundle/')

" Let vundle manage vundle
Plugin 'VundleVim/Vundle.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'Glench/Vim-Jinja2-Syntax'
Plugin 'Raimondi/delimitMate'
Plugin 'Valloric/YouCompleteMe', {'pinned': 1}
Plugin 'airblade/vim-gitgutter'
Plugin 'alfredodeza/coveragepy.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'ambv/black'
Plugin 'benmills/vimux'
Plugin 'chikamichi/mediawiki.vim'
Plugin 'dag/vim-fish'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'elzr/vim-json'
Plugin 'fatih/vim-go', {'pinned': 1}
Plugin 'fisadev/vim-isort'
Plugin 'hynek/vim-python-pep8-indent'
Plugin 'janko-m/vim-test'
Plugin 'jnurmine/Zenburn'
Plugin 'lambdalisue/nose.vim'
Plugin 'maxbrunsfeld/vim-yankstack'
Plugin 'mileszs/ack.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'nvie/vim-flake8'
Plugin 'reinh/vim-makegreen'
Plugin 'scrooloose/syntastic'
Plugin 'terryma/vim-expand-region'
Plugin 'tmhedberg/SimpylFold'
Plugin 'tpope/vim-abolish'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-git'
Plugin 'tpope/vim-vinegar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-scripts/The-NERD-tree'
Plugin 'vim-scripts/mru.vim'
Plugin 'wfscheper/pytest-vim-compiler'

" Required:
call vundle#end()

" Required:
filetype plugin indent on

""""""""""""""""""""""""""""""
" => vim-scripts/mru.vim
""""""""""""""""""""""""""""""
let MRU_Max_Entries = 400
map <leader>f :MRU<CR>


""""""""""""""""""""""""""""""
" => YankStack
""""""""""""""""""""""""""""""
nmap <c-p> <Plug>yankstack_substitute_older_paste
nmap <c-n> <Plug>yankstack_substitute_newer_paste


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Coveragepy
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle the report split
nmap <leader>c :Coveragepy session<cr>
" Reload coverage report and markings
nmap <leader>C :Coveragepy report<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => ambv/black
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:black_linelength = 132


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntastic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Syntastic+vim-go
let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }

" Syntastic+python
let g:syntastic_python_checkers = ['python', 'flake8']

" Syntastic+sphinx
let g:syntastic_rst_checkers = ['sphinx']


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YouCompletMe
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_python_binary_path = 'python'
let g:ycm_autoclose_preview_window_after_insertion = 1

" YCM commands
nmap <leader>K :YcmCompleter GetDoc<cr>
nmap <leader>k :YcmCompleter GoTo<cr>
nmap <leader>yr :YcmCompleter GoToReferences<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => SimpylFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview = 1  " Show docstring preview in folds


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimux
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <leader>vr :VimuxRunCommand("")<left><left>
map <leader>vl :VimuxRunLastCommand<CR>
map <leader>vp :VimuxPromptCommand <CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-test
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MakeGreen
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>m :MakeGreen<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Set expand-region keybindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => airline configuraiton
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => lightline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ ['mode', 'paste'],
      \             ['fugitive', 'readonly', 'filename', 'modified'] ],
      \   'right': [ [ 'lineinfo' ], ['percent'] ]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"🔒":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
      \ 'separator': { 'left': ' ', 'right': ' ' },
      \ 'subseparator': { 'left': ' ', 'right': ' ' }
      \ }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:NERDTreeWinPos = "right"
let NERDTreeShowHidden=0
let NERDTreeIgnore = ['\.pyc$', '__pycache__']
let g:NERDTreeWinSize=35
map <leader>nn :NERDTreeToggle<cr>
map <leader>nb :NERDTreeFromBookmark<Space>
map <leader>nf :NERDTreeFind<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => YAPF
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <C-Y> :call yapf#YAPF()<cr>
imap <C-Y> <c-o>:call yapf#YAPF()<cr>
autocmd FileType python nnoremap <leader>y :0,$!yapf<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-json
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_json_syntax_conceal = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" use goimorts as autofmt command
let g:go_fmt_command = "goimports"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vim-isort
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" pick the python interpreter
if exists('py2')
    let g:vim_isort_python_version = 'python2'
else
    let g:vim_isort_python_version = 'python3'
endif
