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
"    => General
"    => VIM user interface
"    => Searching
"    => Colors and Fonts
"    => Files and backups
"    => Text, tab and indent related
"    => Visual mode related
"    => Moving around, tabs and buffers
"    => Status line
"    => General mappings
"    => vimgrep searching and cope displaying
"    => Spell checking
"    => Misc
"    => Helper functions
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" => General {{{
""""""""""""""""

let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

set autoread                    " Set to auto read when a file is changed from the outside
set backspace=eol,start,indent  " make backspace behave like other editors
set clipboard=unnamed           " use unnamed register for clipboard
set history=1000                " Sets how many lines of history VIM has to remember
set shell=/bin/sh               " set default shell (i use fish and vim doesn't like it)
set whichwrap+=<,>,h,l          " h, l wrap lines

if has('nvim')
    " show results of substition as they're happening
    " but don't open a split
    set inccommand=nosplit
endif
" }}}


" => VIM user interface {{{
"""""""""""""""""""""""""""

" highlight merge conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

set cmdheight=2
set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
set gdefault                " default to /g in replace commands
set hidden                  " current buffer can be put into background
set magic                   " for regular expressions turn magic on
set matchtime=2             " highlight matching braces for N tenths of a second
set modeline                " enable modelines
set number                  " show current line number
set relativenumber          " show relative line numbers
set ruler                   " always show current position
set scrolloff=7             " Set 7 lines to the cursor - when moving vertically using j/k
set shortmess+=c            " suppress completion match messages
set showcmd                 " show incomplet commands
set showmatch               " highlight matching braces
set title                   " set terminal title
set ttyfast                 " enable faster redraws (vim only)
set wildmenu                " turn on enhanced command-line completion
set wildmode=list:longest   " more shell-esque completion


" -> error bells
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noerrorbells            " disable bell sounds on errors
set novisualbell            " disable flash on errors
set t_vb=
set timeoutlen=500


" -> code folding
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set foldlevel=1
set foldlevelstart=99   " always start with all folds open
set foldmethod=syntax   " fold based on syntax indentation
set foldnestmax=10      " deepest fold is 10 levels
set nofoldenable        " don't fold by default


" -> invisible characters
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set list    " show invisible characters
set listchars=tab:→\ ,eol:¬,trail:⋅,extends:❯,precedes:❮


" -> line wrapping
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set linebreak               " enable soft line wrapping
set showbreak=↪             " character used to mark a soft line wrap
set wrap                    " enable wrapping of long lines
set wrapmargin=8            " wrap lines when coming within n characters from side
" ignore repository hidden directories in completions
if has('win16') || has('win32')
    set wildignore+=.git\*,.hg\*.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif


" -> terminal configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set t_Co=256 " Explicitly tell vim that the terminal supports 256 colors
" switch cursor to line when in insert mode, and block when not
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175

if &term =~ '256color'
    " disable background color erase
    set t_ut=
endif

" enable 24 bit color support if supported
if (has("termguicolors"))
    if (!(has("nvim")))
        let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    endif
    set termguicolors
endif
" }}}


" => Searching {{{
""""""""""""""""""

set hlsearch    " Highlight search results
set ignorecase  " Ignore case when searching
set incsearch   " Makes search act like search in modern browsers
set lazyredraw  " Don't redraw while executing macros (good performance config)
set smartcase   " When searching try to be smart about cases

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>
" }}}


" => Colors and Fonts {{{
"""""""""""""""""""""""""

try
    colorscheme desert
catch
endtry

set background=dark

syntax on   " turn on syntax highlighting
filetype plugin indent on   " turn on filetype plugins

" make the highlighting of tabs and other non-text less annoying
highlight SpecialKey ctermfg=19 guifg=#333333
highlight NonText ctermfg=19 guifg=#333333

" make comments and HTML attributes italic
highlight Comment cterm=italic term=italic gui=italic
highlight htmlArg cterm=italic term=italic gui=italic
highlight xmlAttrib cterm=italic term=italic gui=italic
" highlight Type cterm=italic term=italic gui=italic
highlight Normal ctermbg=none
" }}}


" => Files, backups and undo {{{
""""""""""""""""""""""""""""""""
" Fast saving
nmap <leader>w :w!<cr>

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" }}}


" => Text, tab and indent related {{{
"""""""""""""""""""""""""""""""""""""

set autoindent      " copy indent level from current line
set expandtab       " use spaces instead of tabs
set shiftround      " round indents to a multiple of 'shiftwidth'
set shiftwidth=4    " indent with 4 spaces
set smartindent     " enable smart autoindenting of new lines
set smarttab        " tab respects 'tabstop', 'shiftwidt', and 'softtabstop'
set softtabstop=4   " tabs take up 4 spaces in edit modes
set tabstop=4       " tabs take up 4 spaces
" }}}


" => Visual mode related {{{
""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>

" keep visual selection when indenting/outdenting
vmap < <gv
vmap > >gv
" }}}


" => Moving around, tabs, windows and buffers {{{
"""""""""""""""""""""""""""""""""""""""""""""""""
" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" -> buffer controls {{{
map <leader>ba :bufdo bd<cr>
map <leader>bd :Bclose<cr>:tabclose<cr>gT
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>

" Opens a new buffer with the current buffer's path
" Super useful when editing files in the same directory
map <leader>be :edit <c-r>=expand("%:p:h")<cr>/

" Specify the behavior when switching between buffers 
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry
"  }}}

" -> tab controls {{{
map <leader>tN :tabnew<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove<cr>
map <leader>tn :tabnext<cr>
map <leader>to :tabonly<cr>
map <leader>tp :tabprevious<cr> 

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/
"  }}}

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" }}}


" => Status line {{{
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
" }}}


" => Editing mappings {{{
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

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
    let save_cursor = getpos(".")
    let old_query = getreg('/')
    silent! %s/\s\+$//e
    call setpos('.', save_cursor)
    call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif
" }}}


" => Spell checking {{{
"""""""""""""""""""""""
" toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>s? z=
map <leader>sa zg
map <leader>sn ]s
map <leader>sp [s
" }}}


" => Misc {{{
"""""""""""""
" setup python3 provider
let g:python3_host_prog  = '~/.pyenv/versions/neovim/bin/python'
let g:python_host_prog = '~/.virtualenvs/neovim2/bin/python'

" set keystrokes to toggle paste mode
set pastetoggle=<leader>pp

" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Rescan syntax highlighting
map <silent> <leader>R :syntax sync fromstart<cr>

" Open vimgrep and put the cursor in the right position
map <leader>G :vimgrep // **/*<left><left><left><left><left><left>

" Vimgreps in the current file
map <leader>Gc :vimgrep // <C-R>%<C-A><right><right><right><right><right><right><right><right><right>

" When you press <leader>r you can search and replace the selected text
vnoremap <silent> <leader>r :call VisualSelection('replace', '')<CR>

" Do :help cope if you are unsure what cope is. It's super useful!
"
" When you search, display your results in cope by doing:
"k  <leader>cc
"
" To go to the next search result do:
"   <leader>cn
"
" To go to the previous search results do:
"   <leader>cp
"
map <leader>cc :botright cope<cr>
map <leader>co ggVGy:tabnew<cr>:set syntax=qf<cr>pgg
map <leader>cn :cn<cr>
map <leader>cp :cp<cr>

" move through location list
map <leader>ll :botright lope<cr>
map <leader>ln :lnext<cr>
map <leader>lp :lprevious<cr>
" }}}


" => Helper functions {{{
"""""""""""""""""""""""""
" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
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

function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction 

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" Set up a keymapping from <Leader>df to a function call.
" (Note the function doesn't need to be defined beforehand.)
" Run this mapping silently. That is, when I call this mapping,
" don't bother showing "call DiffToggle()" on the command line.
nnoremap <silent> <leader>df :call DiffToggle()<CR>

" Define a function called DiffToggle.
" The ! overwrites any existing definition by this name.
function! DiffToggle()
    " Test the setting 'diff', to see if it's on or off.
    " (Any :set option can be tested with &name.
    " See :help expr-option.)
    if &diff
        diffoff
    else
        diffthis
    endif
:endfunction
" }}}
