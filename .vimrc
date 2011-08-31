set encoding=utf-8
set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Vundle help
""""""""""""""
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" System
Bundle 'tpope/vim-fugitive'
Bundle 'msanders/snipmate.vim'
Bundle 'mileszs/ack.vim'
Bundle 'vim-scripts/AutoClose'
Bundle 'scrooloose/snipmate-snippets'
Bundle 'scrooloose/nerdcommenter'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-git'
Bundle 'ervandew/supertab'
Bundle 'sjl/gundo.vim'
Bundle 'vim-scripts/TaskList.vim'
Bundle 'vim-scripts/taglist.vim'

" HTML/XML
Bundle 'tpope/vim-ragtag'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}

" Jekyll/Liquid
Bundle 'tpope/vim-liquid'

" Python bundles
Bundle 'mitechie/pyflakes-pathogen'
Bundle 'fs111/pydoc.vim'
Bundle 'vim-scripts/pep8'
Bundle 'alfredodeza/pytest.vim'
Bundle 'reinh/vim-makegreen'
Bundle 'sontek/rope-vim'

" Ruby specific
Bundle "vim-ruby/vim-ruby"

" Other
Bundle 'rodjek/vim-puppet'
Bundle 'tpope/vim-haml'
Bundle 'tpope/vim-endwise'

" Non-github repos
Bundle 'git://git.wincent.com/command-t.git'

" Fun, but not useful
Bundle 'altercation/vim-colors-solarized'
Bundle 'skammer/vim-css-color'
Bundle 'mgutz/vim-colors'
Bundle 'ehamberg/vim-cute-python'
Bundle 'tpope/vim-speeddating'

filetype plugin indent on     " required!

" Configurations
""""""""""""""""
if has('gui_running')
	set background=light
else
	set background=dark
endif

" Colours
colorscheme chance-of-storm

set ffs=unix,dos,mac "Default file types

" Basic
syntax enable
set number        " always show line numbers
set hidden
set backspace=indent,eol,start
set nowrap        " don't wrap lines
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "    case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set wildignore=*.swp,*.bak,*.pyc,*.class
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:→\ ,trail:·

" Tabs & spaces
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

" Code Folding
set foldmethod=indent
set foldlevel=99


" Auto-commands
"""""""""""""""
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd filetype python set expandtab
autocmd filetype html,xml set listchars=tab:→\
autocmd filetype ruby set shiftwidth=2 tabstop=2


" Make sure we hilight extra whitespace in the most annoying way possible.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Custom mappings
""""""""""""""""""

" Change leader
let mapleader = ","
let g:mapleader = ","

" Get rid of search hilighting with ,/
nmap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null


" Plugin configurations
""""""""""""""""""""""""

" Easymotion
let g:EasyMotion_leader_key = '<Leader>m'

" TaskList
map <leader>l <Plug>TaskList

"Taglist
nnoremap <silent> <F8> :TlistToggle<CR>

" Gundo
map <leader>u :GundoToggle<CR>

" Command-T
map <Leader>r :CommandT<CR>

" Supertab
let g:SuperTabDefaultCompletionType = "context"
set completeopt=menuone,longest,preview

" NERDTree
map <leader>g :NERDTreeToggle<CR>

" Py.test
" Execute the tests
nmap <silent><Leader>tf <Esc>:Pytest file<CR>
nmap <silent><Leader>tc <Esc>:Pytest class<CR>
nmap <silent><Leader>tm <Esc>:Pytest method<CR>
" cycle through test errors
nmap <silent><Leader>tn <Esc>:Pytest next<CR>
nmap <silent><Leader>tp <Esc>:Pytest previous<CR>
nmap <silent><Leader>te <Esc>:Pytest error<CR>

