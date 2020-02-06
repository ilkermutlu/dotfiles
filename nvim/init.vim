set relativenumber

" indentation
set autoindent     " new lines inherit indentation
set expandtab      " convert tabs to spaces
set shiftround     " when shifting lines, round the indentation to the nearest multiple of “shiftwidth.”
set shiftwidth=4   " when shifting, indent using four spaces.
set tabstop=4      " indent using 4 spaces
set smarttab       " insert 4 spaces on tab

" search
set hlsearch       "search highlighting
set ignorecase     " case insensitive search
set incsearch      " incremental search
set smartcase      " switch to case sensitive if query has uppercase

" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'mhartington/oceanic-next' " color scheme
Plug 'maxmellon/vim-jsx-pretty' " jsx syntax
Plug 'othree/yajs.vim'          " js syntax
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif

" Theme
syntax enable
colorscheme OceanicNext

" NERDTree
map <C-n> :NERDTreeToggle<CR>
