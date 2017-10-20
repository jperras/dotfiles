" File ~/.nvimrc

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'

" General

" Disable this for now, while I try out (U|De)nite
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Git plugin
Plug 'jreybert/vimagit'

" Use fugitive since vimagit can't really do blame/etc. just yet.
Plug 'tpope/vim-fugitive'

" show add/deletions in sidebar gutter
Plug 'airblade/vim-gitgutter'

" Syntax aware commenting.
Plug 'scrooloose/nerdcommenter'

" Streamlined statusline.
Plug 'bling/vim-airline'

" Smarter search/replace with :S (:Subvert) and %S (%Subvert)
Plug 'tpope/vim-abolish'

" Automatically insert or delete brackets, parens, quotes in pair.
Plug 'jiangmiao/auto-pairs'

" Editorconfig settings
Plug 'editorconfig/editorconfig-vim'

" Custom marks/shortcuts to jump to marks
Plug 'kshenoy/vim-signature'

" Custom start screen
Plug 'mhinz/vim-startify'

" Bracket pair mapping
Plug 'tpope/vim-unimpaired'

" Syntax checker
Plug 'w0rp/ale'

" Completions for rust
Plug 'racer-rust/vim-racer'

" Completion framework & plugins.
"""""""""""""""""""""""""""""""""
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/python-support.nvim'

" for python completions
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'jedi')
" language specific completions on markdown file
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'mistune')

" utils, optional
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'psutil')
let g:python_support_python3_requirements = add(get(g:,'python_support_python3_requirements',[]),'setproctitle')

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'saltstack/salt-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'rust-lang/rust.vim'
Plug 'chemzqm/vim-jsx-improve'
Plug 'stephpy/vim-yaml'
Plug 'fatih/vim-go'
Plug 'tpope/vim-liquid'

" REStructuredText
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'

" Ctags tagbar
Plug 'majutsushi/tagbar'

" Allow better soft-wrapping of text in prose-based
" formats e.g. markdown.
Plug 'junegunn/goyo.vim'

" Markdown syntax augmentation
Plug 'rhysd/vim-gfm-syntax'

" The all-important colorschemes
Plug 'joshdick/onedark.vim'

set laststatus=2

call plug#end()

" Colorscheme configuration
set background=dark
colorscheme onedark

" Basic configurations
""""""""""""""""""""""
let mapleader = ","
set number " Relative line numbering
set relativenumber " Relative line numbering
set ignorecase! " Ignore case in search
set hidden " Hide instead of close bufffers to preserve history
set synmaxcol=200 " only syntax highlight first 200cols for performance reasons.
set conceallevel=2 " Conceal syntax elements.

" Toggle highlight on ,/
nnoremap <leader>/ :set hlsearch!<CR>

" I CAN HAZ NORMAL REGEXES?
nnoremap / /\v
vnoremap / /\v

set grepprg=rg\ --vimgrep " Use ripgrep for regular grep

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:»\ ,trail:·

" Where swap and backup files go
set backupdir=~/.config/nvim/backup_files//
set directory=~/.config/nvim/swap_files//
set undodir=~/.config/nvim/undo_files//

" FZF file finder plugin
""""""""""""""""""""""""
noremap <C-p> :FZF<CR>
let g:fzf_height = '30%'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_tags_options = '-f .ctags"'

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --no-ignore: Do not respect .gitignore, etc...
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>), 1, <bang>0)

" NERDTree
""""""""""
noremap <leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.egg$', '\.o$', '\~$', '__pycache__$', '\.egg-info$', 'node_modules$']

" Tagbar/ctags
""""""""""""""
nmap <F2> :TagbarToggle<CR>

autocmd FileType jinja,html setlocal shiftwidth=2 expandtab tabstop=2 softtabstop=2

" Python specific configs
"""""""""""""""""""""""""
" We like spaces; avoid tabs. Set colorcolumn.
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4 colorcolumn=80

" GOYO - distractionless writing

"""""""""""""""""""""""""""""""""
" Enter goyo for mail
autocmd FileType mail Goyo

" Add format option 'w' to add trailing white space, indicating that paragraph
" continues on next line. This is to be used with mutt's 'text_flowed' option.
augroup mail_trailing_whitespace " {
    autocmd!
    autocmd FileType mail setlocal formatoptions+=w
augroup END " }

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  setl spell spelllang=en_us
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

" Worp/ale configuration
"""""""""""""""""""

" Ignore line too long error and specific hanging indent error
let g:ale_python_flake8_args="--ignore=E501,E128"

" Airline configuration
"""""""""""""""""""""""

" Use theme for Airline
let g:airline_theme='onedark'

" Display all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1

" Worp/ale syntax checker
let g:airline#extensions#ale#enabled = 1

" Vim-Golang plugin configs
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports"

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
" (Sourced from http://nerditya.com/code/guide-to-neovim/)
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Markdown-ish configurations
"""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'ruby']
let g:vim_markdown_frontmatter=1

" Editorconfig exceptions
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" specify the default virtualenv for neovim.
let g:python3_host_prog = '/Users/hoth/.virtualenvs/neovim/bin/python3.5'

" Markdown fenced code highlighting (GFM)
let g:markdown_fenced_languages = ['python', 'json']

" Rust racer
let g:racer_cmd = "/Users/hoth/.cargo/bin/racer"
let g:racer_experimental_completer = 1
let g:rustfmt_autosave = 1
