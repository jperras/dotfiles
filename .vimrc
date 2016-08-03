" File ~/.nvimrc

call plug#begin('~/.config/nvim/plugged')

Plug 'tpope/vim-sensible'

" General
Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdcommenter'
Plug 'bling/vim-airline'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'editorconfig/editorconfig-vim'
Plug 'kshenoy/vim-signature'
Plug 'tweekmonster/braceless.vim'
Plug 'Shougo/deoplete.nvim'
Plug 'mhinz/vim-startify'


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
Plug 'chriskempson/base16-vim'

" REStructuredText
Plug 'Rykka/riv.vim'
Plug 'Rykka/InstantRst'

" Ctags tagbar
Plug 'majutsushi/tagbar'

" Allow better soft-wrapping of text in prose-based
" formats e.g. markdown.
Plug 'reedes/vim-pencil'

" Markdown syntax augmentation
Plug 'tpope/vim-markdown'
Plug 'junegunn/goyo.vim'

" The all-important colorschemes
Plug 'altercation/vim-colors-solarized'
Plug '29decibel/codeschool-vim-theme'
Plug 'morhetz/gruvbox'
Plug 'reedes/vim-colors-pencil'
Plug 'vim-airline/vim-airline-themes'

set laststatus=2

call plug#end()

" Colorscheme
set termguicolors
set background=dark
let g:gruvbox_italic=1
let g:gruvbox_italicize_comments=1
let g:gruvbox_italicize_strings=1
colorscheme gruvbox

"let base16colorspace=256
"colorscheme base16-eighties

" Basic configurations
""""""""""""""""""""""
let mapleader = ","
set number " Line numbers
set ignorecase! " Ignore case in search
set hidden " Hide instead of close bufffers to preserve history

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

" Braceless.vim configuration
"""""""""""""""""""""""""""""
" Use braceless plugin for python-aware indenting, folding
autocmd FileType python BracelessEnable +indent +fold

" Use braceless configuration for haml, yaml, coffeescript since none of those
" use braces
autocmd FileType haml,yaml,coffee BracelessEnable +indent +fold +highlight

let g:braceless_cont_call = 1
let g:braceless_cont_block = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Syntax checker options
let g:flake8_ignore="E128,E501"

" Syntastic settings
""""""""""""""""""""
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_auto_jump = 0
let g:syntastic_enable_signs = 1
let g:syntastic_error_symbol = "✗"
let g:syntastic_warning_symbol = "⚠"
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_python_checkers = ['flake8']
let g:syntastic_disabled_filetypes=['html', 'jinja']
let g:syntastic_python_flake8_args='--ignore=E501,E128'


" Airline configuration
"""""""""""""""""""""""

" Don't use powerline fonts
let g:airline_powerline_fonts = 0
let g:airline_symbols = {}

" Don't show separators
let g:airline_left_sep=''
let g:airline_right_sep=''

" Use theme for Airline
let g:airline_theme='papercolor'

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

 " Configure vim-pencil
let g:pencil#wrapModeDefault = 'soft'   " default is 'hard'
augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,liquid call pencil#init()
                            \ | setl spell spl=en_us fdl=4 noru nonu nornu
                            \ | setl fdo+=search
  autocmd Filetype git,gitsendemail,*commit*,*COMMIT*
                            \   call pencil#init()
                            \ | setl spell spl=en_us et sw=2 ts=2 tw=72 noai
  autocmd Filetype mail         call pencil#init({'wrap': 'hard', 'textwidth': 80})
                            \ | setl spell spl=en_us et sw=2 ts=2 noai nonu nornu
  autocmd Filetype html,xml     call pencil#init({'wrap': 'soft'})
                            \ | setl spell spl=en_us et sw=2 ts=2
augroup END

let g:airline_section_x = '%{PencilMode()}'

" Markdown-ish configurations
"""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = ['javascript', 'js=javascript', 'json=javascript', 'ruby']
let g:vim_markdown_frontmatter=1

" Editorconfig exceptions
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
