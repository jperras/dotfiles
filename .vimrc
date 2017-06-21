" File ~/.nvimrc

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'

" General
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'kshenoy/vim-signature'
Plug 'mhinz/vim-startify'
Plug 'janko-m/vim-test'
Plug 'jmcantrell/vim-virtualenv'
Plug 'tpope/vim-unimpaired'
Plug 'w0rp/ale'

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

" In-file searching ala 'ack'
Plug 'gabesoft/vim-ags'

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'saltstack/salt-vim'
Plug 'stephpy/vim-yaml'
Plug 'fatih/vim-go'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'tpope/vim-liquid'
Plug 'IN3D/vim-raml'

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
Plug 'morhetz/gruvbox'
Plug 'altercation/vim-colors-solarized'
Plug 'vim-airline/vim-airline-themes'
Plug 'liuchengxu/space-vim-dark'
Plug 'josuegaleas/jay'
Plug 'ajmwagar/vim-dues'

set laststatus=2

call plug#end()

" Colorscheme
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=1
"colorscheme gruvbox
"colorscheme space-vim-dark
colorscheme dues

" Basic configurations
""""""""""""""""""""""
let mapleader = ","
set number " Relative line numbering
set relativenumber " Relative line numbering
set ignorecase! " Ignore case in search
set hidden " Hide instead of close bufffers to preserve history
set synmaxcol=200 " only syntax highlight first 200cols for performance reasons.

" Toggle highlight on ,/
nnoremap <leader>/ :set hlsearch!<CR>

" I CAN HAZ NORMAL REGEXES?
nnoremap / /\v
vnoremap / /\v

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" Special characters for hilighting non-priting spaces/tabs/etc.
set list listchars=tab:»\ ,trail:·

" Where swap and backup files go
set backupdir=~/.config/nvim/backup_files//
set directory=~/.config/nvim/swap_files//
set undodir=~/.config/nvim/undo_files//

hi Search ctermfg=0 ctermbg=11 guifg=Black guibg=Yellow
hi SpellBad ctermfg=15 ctermbg=9 guifg=White guibg=Red
hi Comment cterm=italic

" FZF file finder plugin
""""""""""""""""""""""""
noremap <C-p> :FZF<CR>
let g:fzf_height = '30%'
let g:fzf_command_prefix = 'Fzf'
let g:fzf_tags_options = '-f .ctags"'

" Tagbar/ctags
""""""""""""""
nmap <F2> :TagbarToggle<CR>

" NERDTree
""""""""""
noremap <leader>t :NERDTreeToggle<CR>

let NERDTreeIgnore = ['\.pyc$', '\.egg$', '\.o$', '\~$', '__pycache__$', '\.egg-info$']

autocmd FileType jinja,html setlocal shiftwidth=2 expandtab tabstop=2 softtabstop=2

" Python specific configs
"""""""""""""""""""""""""
" We like spaces; avoid tabs. Set colorcolumn.
"autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4 colorcolumn=80 omnifunc=pythoncomplete#Complete
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4 colorcolumn=80

" Use braceless configuration for haml, yaml, coffeescript since none of those
" use braces
autocmd FileType haml,yaml,coffee BracelessEnable +indent +fold +highlight

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

" Use deoplete.
"let g:deoplete#enable_at_startup = 1

" Configure deoplete-jedi
"let g:deoplete#sources#jedi#python_path = '/usr/local/bin/python'  "force python2
"let g:jedi#use_splits_not_buffers = "left"

" ale configuration
"""""""""""""""""""
let g:ale_python_flake8_args="--ignore=E501,E128"

" Airline configuration
"""""""""""""""""""""""

" Use theme for Airline
let g:airline_theme='base16_spacemacs'

let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = airline#section#create('%{virtualenv#statusline()}')

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

" Highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$\|\t/

" Markdown-ish configurations
"""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'ruby']
let g:vim_markdown_frontmatter=1

" Editorconfig exceptions
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" Vim-test
let test#strategy = "neovim"

" specify the default virtualenv for neovim.
let g:python3_host_prog = '/Users/hoth/.virtualenvs/neovim/bin/python3.5'


" Markdown fenced code highlighting
let g:markdown_fenced_languages = ['python', 'json']
