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

Plug 'vim-airline/vim-airline'

Plug 'pangloss/vim-javascript'   " js syntax
Plug 'maxmellon/vim-jsx-pretty' " jsx syntax

Plug 'mtdl9/vim-log-highlighting' "log highlighting https://github.com/MTDL9/vim-log-highlighting
Plug 'neoclide/coc.nvim', {'branch': 'release'} "intellisense
Plug 'rust-lang/rust.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
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
let g:ale_fix_on_save = 1
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" COC Configuration
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if has('patch8.1.1068')
  " Use `complete_info` if your (Neo)Vim version supports it.
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" " Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation".
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

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

" Signify
nnoremap <silent> <leader>shd :SignifyHunkDiff<CR>
nnoremap <silent> <leader>shu :SignifyHunkUndo<CR>

" Narrow Region Settings
let g:nrrw_rgn_vert = 1
let g:nrrw_rgn_wdth = 90
