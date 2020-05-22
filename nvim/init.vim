set number relativenumber

let mapleader = ','

" indentation
set autoindent     " new lines inherit indentation
set expandtab      " convert tabs to spaces
set shiftround     " when shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
set shiftwidth=4   " when shifting, indent using four spaces.
set tabstop=4      " indent using 4 spaces
set smarttab       " insert 4 spaces on tab

" search
set hlsearch       " search highlighting
set ignorecase     " case insensitive search
set incsearch      " incremental search
set smartcase      " switch to case sensitive if query has uppercase
set colorcolumn=80 

" Clear search by hitting ESC in normal mode
nnoremap <esc> :noh<return><esc>

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'tpope/vim-fugitive'
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" FZF
Plug 'tpope/vim-vinegar'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'easymotion/vim-easymotion'
Plug 'mattn/emmet-vim'
Plug 'chrisbra/NrrwRgn'
Plug 'jiangmiao/auto-pairs'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'

" Linter
Plug 'dense-analysis/ale'

Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'
Plug 'maxmellon/vim-jsx-pretty' " jsx syntax
Plug 'othree/yajs.vim'          " js syntax

Plug 'mtdl9/vim-log-highlighting' "log highlighting https://github.com/MTDL9/vim-log-highlighting
call plug#end()

"if (has("termguicolors"))
" set termguicolors
"endif

" Theme
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

if (has("autocmd"))
  augroup colorextend
    autocmd!
    autocmd ColorScheme * call onedark#extend_highlight("Normal", { "bg": { "gui": "#21242A" } })
    let s:white = { "gui": "#D3D3D3", "cterm": "145", "cterm16" : "7" }
    autocmd ColorScheme * call onedark#set_highlight("Normal", { "fg": s:white })
  augroup END
endif
syntax on
colorscheme onedark
let g:airline_theme='onedark'
" let g:gruvbox_contrast_dark='hard'
" colorscheme gruvbox 

nnoremap ` :Marks<CR> 
map <C-n> :NERDTreeToggle<CR>
" Emmet
let g:user_emmet_leader_key='<C-]>'

" Formatters
au FileType javascript setlocal formatprg=prettier
au FileType javascript.jsx setlocal formatprg=prettier
au FileType typescript setlocal formatprg=prettier\ --parser\ typescript
au FileType html setlocal formatprg=js-beautify\ --type\ html
au FileType scss setlocal formatprg=prettier\ --parser\ css
au FileType css setlocal formatprg=prettier\ --parser\ css

" ALE
let g:ale_linters = {
    \ 'javascript': ['eslint']
\}

let g:ale_fixers = {
    \    'javascript': ['prettier', 'eslint'],
    \    'scss': ['prettier'],
    \    'html': ['prettier'],
\}
let g:ale_fix_on_save = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" FZF Settings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

nnoremap <silent> <leader>f :FZF<cr>
nnoremap <silent> <leader>G :GFiles<cr>
nnoremap <silent> <leader>bu :Buffers<cr>

" Fugitive Bindings
nnoremap <leader>gs :vertical Gstatus<CR>

" Narrow Region Settings
let g:nrrw_rgn_vert = 1
let g:nrrw_rgn_wdth = 90
