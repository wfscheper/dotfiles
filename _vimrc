" set default shell
set shell=/bin/sh

" disable modelines (security issue)
set nomodeline

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load NeoBundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Note: Skip initialization for vim-tiny or vim-small.
if !1 | finish | endif

if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Load Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

NeoBundle 'davidhalter/jedi-vim'
if system("python --version | awk '{print $2}' | awk -F. '{print $1}'") ==# 3
    let g:jedi#force_py_version = 3
else
    let g:jedi#force_py_version = 2
endif
let g:jedi#show_call_signatures = 2

NeoBundle 'vim-scripts/The-NERD-tree'
NeoBundle 'terryma/vim-expand-region'
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

NeoBundle 'benmills/vimux'
NeoBundle 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

NeoBundle 'tmhedberg/SimpylFold'
NeoBundle 'hynek/vim-python-pep8-indent'
NeoBundle 'nvie/vim-flake8'
autocmd BufWritePost *.py call Flake8()

NeoBundle 'Konfekt/FastFold'
NeoBundle 'reinh/vim-makegreen'
NeoBundle 'lambdalisue/nose.vim'
NeoBundle '5long/pytest-vim-compiler'
NeoBundle 'Raimondi/delimitMate'
NeoBundle 'jnurmine/Zenburn'
NeoBundle 'altercation/vim-colors-solarized'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'elzr/vim-json'
NeoBundle 'dag/vim-fish'
NeoBundle 'tpope/vim-dispatch'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'fatih/vim-go'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'janko-m/vim-test'
let test#strategy = 'dispatch'
let test#python#pytest#file_pattern = '^.*test.*\.py$'

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=700

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Leader bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Run tests
nmap <leader>m :MakeGreen<cr>
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>l :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>

" NERDTreeToggle
nmap <Leader>N :NERDTreeToggle<CR>

" Vimux commands
map <Leader>vr :VimuxRunCommand("")<left><left>
map <Leader>vl :VimuxRunLastCommand<CR>
map <Leader>vp :VimuxPromptCommand <CR>

" manually run pymode lint
map <Leader>L :PymodeLint<CR>

" Fast saving
nmap <leader>w :w!<cr>

" Reload vimrc
nmap <leader>r :so $MYVIMRC<cr>

" quick  entry into visual mode
nmap <leader><leader> V

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :nohlsearch<cr>

" Rescan syntax highlighting
map <silent> <leader>R :syntax sync fromstart<cr>

" Buffer mappings
map <leader>bn :bnext<cr>
map <leader>bp :bprev<cr>

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map <leader>tN :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Open vimgrep and put the cursor in the right position
map <leader>G :vimgrep // **/*<left><left><left><left><left><left>

" Vimgreps in the current file
map <leader>Gc :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>h you can search and replace the selected text
vnoremap <silent> <leader>h :call VisualSelection('replace')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search with vimgrep, display your results in cope by doing:
"   <leader>cc
"
" To go to the next search result do:
"   <leader>n
"
" To go to the previous search results do:
"   <leader>p
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>M mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" for when we forget to use sudo to open/edit a file
cmap w!! w !sudo tee % >/dev/null

" prefer vertical splits when diffing
set diffopt+=vertical

" Set 7 lines to the cursor - when moving vertically using j/k
set scrolloff=3

" Turn on the WiLd menu
set wildmenu
set wildmode=list:longest

" Ignore compiled files
set wildignore=*.o,*~,*.pyc

" show relative numbers
set relativenumber

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Makes search act like search in modern browsers
set incsearch

" default to /g in replace commands
set gdefault

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
syntax enable

colorscheme solarized
if expand('$SSH_CONNECTION') == '$SSH_CONNECTION'
    set background=light
else
    set background=dark
endif

" Set extra options when running in GUI mode
if has("gui_running")
    set guioptions-=T
    set guioptions+=e
    set t_Co=256
    set guitablabel=%M\ %t
    set guifont=Consolas:h14,Source\ Code\ Pro:h13,Monospace:h13
endif

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf-8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual display
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Highlight anything in column 80 and beyond
set colorcolumn=79
autocmd FileType python,sh,fish match ErrorMsg /\%80v[^\n].*/


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

" wrapping
set wrap "Wrap lines
set textwidth=79 " wrap at 79 characters
set formatoptions=qrn1

set ai "Auto indent
set si "Smart indent

" mark whitespace characters
set list listchars=tab:»·,trail:·

" Disable F1 key
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" ; = :
nnoremap ; :

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f')<CR>
vnoremap <silent> # :call VisualSelection('b')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l:%c


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has("mac") || has("macunix")
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif

" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => vimgrep searching and cope displaying
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSelection('gv')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autowrite

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make a simple "search" text object.
" http://vim.wikia.com/wiki/Copy_or_change_search_hit
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction
