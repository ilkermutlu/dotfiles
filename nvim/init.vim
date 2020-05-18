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
Plug 'preservim/nerdtree'
Plug 'tpope/vim-fugitive'

" FZF
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'mattn/emmet-vim'

" Linter
Plug 'dense-analysis/ale'

Plug 'mhartington/oceanic-next' " color scheme
Plug 'maxmellon/vim-jsx-pretty' " jsx syntax
Plug 'othree/yajs.vim'          " js syntax

Plug 'mtdl9/vim-log-highlighting' "log highlighting https://github.com/MTDL9/vim-log-highlighting
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

" NERDTree
map <C-n> :NERDTreeToggle<CR>

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
