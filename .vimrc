set nu
set ai
set encoding=utf-8
syntax on
set ignorecase
set hlsearch
set incsearch
set background=dark
set pumheight=10
set laststatus=1
set noswapfile
set completeopt=menu,menuone,noselect
set signcolumn=yes

let mapleader = "\<space>"

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'yegappan/taglist'
Plug 'dense-analysis/ale'
call plug#end()

colorscheme habamax

let g:ctrlp_extensions = ['tag']
nnoremap <silent> <leader>tl :TlistToggle<CR>
let g:gutentags_project_root = ['.git']

" ale
let g:ale_lint_delay = 5000
nmap <silent> [d <Plug>(ale_previous_wrap)
nmap <silent> ]d <Plug>(ale_next_wrap)
let g:ale_virtualtext_cursor = 'current'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_disable_lsp = 1
nnoremap <leader>F :ALEFix<CR>
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format', 'isort']}
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {'python': ['ruff']}
let g:ale_set_signs = 0
