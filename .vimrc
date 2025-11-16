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
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tmsvg/pear-tree'
call plug#end()

colorscheme habamax

let g:ctrlp_extensions = ['tag']
nnoremap <silent> <leader>tl :TlistToggle<CR>
let g:gutentags_project_root = ['.git']

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
