" File ~/.nvimrc

call plug#begin('~/.config/nvim/plugged')

" General

Plug 'tpope/vim-sensible'

" Colorschemes
Plug 'chriskempson/base16-vim'

Plug 'Xuyuanp/nerdtree-git-plugin' | Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Syntax aware commenting.
Plug 'scrooloose/nerdcommenter'

" Git plugin
Plug 'jreybert/vimagit'

" Use fugitive since vimagit can't really do blame/etc. just yet.
Plug 'tpope/vim-fugitive'

" show add/deletions in sidebar gutter
Plug 'airblade/vim-gitgutter'

" Streamlined statusline.
Plug 'itchyny/lightline.vim'

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

" Fuzzy file finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'
Plug 'saltstack/salt-vim'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'rhysd/vim-gfm-syntax'

" For writing prose.
Plug 'reedes/vim-pencil'
Plug 'reedes/vim-wordy'
Plug 'reedes/vim-lexical'

" Ctags tagbar
Plug 'majutsushi/tagbar'

set laststatus=2

call plug#end()

" Colorscheme configuration
set background=dark
colorscheme base16-dracula

" Basic configurations
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" Use italics
let g:onedark_terminal_italics = 1
highlight Comment ctermfg=59 guifg=#5C6370 gui=italic

" Gitgutter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Always show the sign column so that we don't get shifting
" left/right margins.
set signcolumn=yes

" FZF file finder plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

noremap <C-p> :FZF<CR>
let g:fzf_height = '30%'

" All fzf commands will require this prefix
let g:fzf_command_prefix = 'FZ'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'
let g:fzf_tags_options = '-f .ctags"'

" --column: Show column number
" --line-number: Show line number
" --no-heading: Do not show file headings in results
" --fixed-strings: Search term as a literal string
" --ignore-case: Case insensitive search
" --hidden: Search hidden files and folders
" --follow: Follow symlinks
" --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
" --color: Search color options
command! -bang -nargs=* Find
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --ignore-case --glob "!.git/*" '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

" NERDTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
noremap <leader>t :NERDTreeToggle<CR>
let NERDTreeIgnore = ['\.pyc$', '\.egg$', '\.o$', '\~$', '__pycache__$', '\.egg-info$', 'node_modules$']

" Tagbar/ctags
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <F2> :TagbarToggle<CR>

autocmd FileType jinja,html setlocal shiftwidth=2 expandtab tabstop=2 softtabstop=2

" Python specific configs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" We like spaces; avoid tabs. Set colorcolumn.
autocmd FileType python setlocal shiftwidth=4 expandtab tabstop=4 softtabstop=4 colorcolumn=80

" Worp/ale configuration
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Use python3 by default? Let's see how this goes.
let g:ale_python_flake8_executable = 'python3'
let g:ale_python_flake8_options = '-m flake8'

" Ignore line too long error and specific hanging indent error
let g:ale_python_flake8_args="--ignore=E501,E128"

" Status line
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head'
      \ },
      \ }

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
" (Sourced from http://nerditya.com/code/guide-to-neovim/)
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Editorconfig exceptions
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

" PROSE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:pencil#textwidth = 78

augroup pencil
  autocmd!
  autocmd FileType mail call pencil#init({'wrap': 'hard', 'textwidth': 72})
                    \ | call lexical#init()
augroup END

" 24bit true color
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif
