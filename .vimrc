set nu
set ai
set encoding=utf-8
syntax on
filetype on
filetype plugin indent on
set ignorecase
set hlsearch
set ruler
set incsearch
set background=dark
set pumheight=10
set laststatus=1
set noswapfile
set completeopt=menu,menuone,noselect
set nowritebackup
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
Plug 'nvie/vim-flake8'
call plug#end()

colorscheme habamax

" taglist
nnoremap <silent> <leader>tl :TlistToggle<CR>
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

autocmd FileType python map <buffer> <leader>f8 :call flake8#Flake8()<CR>
