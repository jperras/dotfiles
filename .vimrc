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


" VCS
Bundle 'tpope/vim-fugitive'

" System
Bundle 'vim-scripts/Gist.vim'
Bundle 'majutsushi/tagbar'
Bundle 'rking/ag.vim'
Bundle 'tomtom/tcomment_vim'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'Raimondi/delimitMate'
Bundle 'luochen1990/rainbow'
Bundle 'kien/ctrlp.vim'
Bundle 'mhinz/vim-signify'
Bundle 'scrooloose/nerdtree'
Bundle 'jistr/vim-nerdtree-tabs'

" Syntaxes
Bundle 'leshill/vim-json'
Bundle 'puppetlabs/puppet-syntax-vim'
Bundle 'jtratner/vim-flavored-markdown'
Bundle 'othree/html5.vim'
Bundle 'itspriddle/vim-jquery'
Bundle 'atourino/jinja.vim'
Bundle 'saltstack/salt-vim'
Bundle 'ntpeters/vim-better-whitespace'

" Python
Bundle 'nvie/vim-flake8'
Bundle 'fs111/pydoc.vim'

" Ruby
Bundle "vim-ruby/vim-ruby"
Bundle 'tpope/vim-endwise'

" Fun, but not useful
Bundle 'altercation/vim-colors-solarized'
Bundle 'skammer/vim-css-color'
Bundle 'mgutz/vim-colors'
Bundle 'ehamberg/vim-cute-python'
Bundle 'bling/vim-airline'

" Required after vundle plugin definitions
filetype plugin indent on

" Change leader
let mapleader = ","
let g:mapleader = ","

" Wildmenu
set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.git,.svn                    " Version control
set wildignore+=*.aux,*.out,*.toc                " LaTeX intermediate files
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest " compiled object files
set wildignore+=*.spl                            " compiled spelling word lists
set wildignore+=*.sw?                            " Vim swap files
set wildignore+=*.DS_Store                       " OSX bullshit
set wildignore+=*.luac                           " Lua byte code
set wildignore+=*.pyc                            " Python byte code
set wildignore+=**.class                          " Cursed Java class files

" Ignore in buffer explorer
let g:netrw_liststyle= 1 " Tree-mode
let g:netrw_list_hide= '.*\.swp$,.*/$'

" Save when losing focus
set autowriteall " Auto-save files when switching buffers or leaving vim.
au FocusLost * silent! :wa
au TabLeave * silent! :wa

" Resize splits when the window is resized
au VimResized * exe "normal! \<c-w>="

" Basics
syntax enable
set number        " always show line numbers
set hidden        " Allow un-saved buffers in background
set clipboard=unnamed " Share system clipboard.
set backspace=indent,eol,start " Make backspace behave normally.
set directory=/tmp// " swap files
set backupskip=/tmp/*,/private/tmp/*
set ffs=unix,dos,mac "Default file types
set nowrap        " don't wrap lines
set showmatch     " set show matching parenthesis
set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase,
                  "  case-sensitive otherwise
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set history=1000         " remember more commands and search history
set undolevels=1000      " use many muchos levels of undo
set title                " change the terminal's title
set visualbell           " don't beep
set noerrorbells         " don't beep
set guifont=Inconsolata\ for\ Powerline:h13

" Remove the toolbar if we're running under a GUI (e.g. MacVIM).
if has("gui_running")
  set guioptions=-t
endif

" Default background & theme
set background=dark
colorscheme solarized

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:»\ ,trail:·

" Default Tabs & spaces
set tabstop=4     " a tab is four spaces
set shiftwidth=4  " number of spaces to use for autoindenting
set softtabstop=4
set expandtab
set shiftround    " use multiple of shiftwidth when indenting with '<' and '>'
set smarttab      " insert tabs on the start of a line according to
                  "    shiftwidth, not tabstop
set autoindent    " always set autoindenting on
set copyindent    " copy the previous indentation on autoindenting

" General Code Folding
set foldmethod=indent
set foldlevel=99

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" I CAN HAZ NORMAL REGEXES?
nnoremap / /\v
vnoremap / /\v

" Make sure we hilight extra whitespace in the most annoying way possible.
" highlight ExtraWhitespace ctermbg=red guibg=red
" match ExtraWhitespace /\s\+$/
" autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
" autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
" autocmd InsertLeave * match ExtraWhitespace /\s\+$/


" General auto-commands
autocmd FileType * setlocal colorcolumn=0
" autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red

" Get rid of trailing whitespace highlighting in mutt.
autocmd FileType mail highlight clear ExtraWhitespace
autocmd FileType mail setlocal listchars=

" Toggle spellcheck in normal mode
:map <F5> :setlocal spell! spelllang=en_us<CR>


" Markdown configurations
augroup markdown
    au!
    au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Ruby Configurations
autocmd filetype ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 shiftwidth=2 colorcolumn=80

" PHP Configurations
autocmd FileType php setlocal colorcolumn=100

" HTML configurations
autocmd FileType html setlocal shiftwidth=4 tabstop=4 softtabstop=4 noexpandtab

" Python configurations
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4
autocmd FileType python setlocal colorcolumn=80
autocmd FileType python map <buffer> <F4> :call Flake8()<CR>
autocmd FileType python autocmd BufWritePre * :%s/\s\+$//e
autocmd FileType python set omnifunc=pythoncomplete#Complete

" Javascript configurations
au BufNewFile,BufReadPost *.js setlocal shiftwidth=2 expandtab

" Ensure that JSON files have their filetype properly set.
au BufRead,BufNewFile *.json set filetype=json

" Puppet configurations
au FileType puppet setlocal noexpandtab

" Get jinja filetype selection working correctly for *.jinja.html files.
au BufNewFile,BufReadPost *.jinja* setlocal filetype=htmljinja

" Get rid of search hilighting with ,/
nnoremap <silent> <leader>/ :nohlsearch<CR>

" Fix those pesky situations where you edit & need sudo to save
cmap w!! w !sudo tee % >/dev/null


" Plugin Configurations
"""""""""""""""""""""""

" Pyflakes
"autocmd BufWritePost *.py call Flake8()
let g:flake8_ignore="E128,E501"
let g:syntastic_python_checker_args='--ignore=E501,E128'

" Gist
let g:gist_clip_command = 'pbcopy'
let g:gist_detect_filetype = 2
let g:gist_show_privates = 1
let g:gist_post_private = 1

" TagBar
nnoremap <silent> <F2> :TagbarToggle<CR>
let g:tagbar_ctags_bin = '/usr/local/bin/ctags'
let g:tagbar_autoshowtag = 1
let g:tagbar_autofocus = 1

" crtl-p
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'  " search anything (in files, buffers and MRU files at the same time.)
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard']
let g:ctrlp_custom_ignore = '\v\~$|\.(o|swp|pyc|wav|mp3|ogg|blend)$|(^|[/\\])\.(hg|git|bzr)($|[/\\])|__init__\.py'
"let g:ctrlp_working_path_mode = 'ra' " search for nearest ancestor like .git, .hg, and the directory of the current file
let g:ctrlp_match_window_bottom = 0 " show the match window at the top of the screen
let g:ctrlp_max_height = 10 " maxiumum height of match window
let g:ctrlp_switch_buffer = 'et' " jump to a file if it's open already
let g:ctrlp_use_caching = 1 " enable caching
let g:ctrlp_clear_cache_on_exit=0 " speed up by not removing clearing cache evertime
let g:ctrlp_show_hidden = 0 " don't show me dotfiles
let g:ctrlp_mruf_max = 250 " number of recently opened files
nmap ; :CtrlPBuffer<CR>

" Double rainbow - What does it mean!?
let g:rainbow_active = 1

set laststatus=2
let g:syntastic_enable_signs = 1
let g:syntastic_auto_jump = 0
let g:syntastic_puppet_lint_disable = 0

" Airline configs
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

" NerdTree
map <leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0
