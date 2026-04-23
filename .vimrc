syntax on

set encoding=utf-8

set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set smarttab

set autoindent
set smartindent

set updatetime=300
set signcolumn=yes

set hlsearch
set incsearch
set ignorecase
set smartcase
set nowrapscan

set number
set ruler

set scrolloff=5
set sidescrolloff=5
set wrap

set pumheight=10
set completeopt=menuone,longest,preview

set mouse=a
set laststatus=2
set showtabline=0
set backspace=indent,eol,start

set noswapfile
set nobackup
set nowritebackup

set showmatch
set matchtime=2

set showcmd
set wildmenu

set hidden
set autoread

set splitright
set splitbelow

set foldmethod=syntax
set foldlevel=99


set cpt+=.,w,b,u,t,i,o

set ttyfast
set lazyredraw
set nobackup


nnoremap <silent> <space>lg :call FloatingLazygit()<CR>

let mapleader = "\<Space>"

call plug#begin()
Plug 'shrikecode/kyotonight.vim'
Plug 'tomasr/molokai'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'preservim/tagbar'
Plug 'ludovicchabant/vim-gutentags'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-flagship'
Plug 'rust-lang/rust.vim'
Plug 'tpope/vim-dispatch'
Plug 'christoomey/vim-tmux-navigator'
call plug#end()

colorscheme molokai

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-l>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
nmap ghp <Plug>(GitGutterPreviewHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending) xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

nnoremap <leader>q :copen<CR>
nnoremap <leader>cq :cclose<CR>
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

nnoremap <C-p> :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>g :GFiles<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>ft :Tags<CR>
nnoremap <leader>fm :Marks<CR>
nnoremap <C-c> :Commands<CR>



imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)

function! GitGutterFlag()
    let [added, modified, removed] = GitGutterGetHunkSummary()
    if added == 0 && modified == 0 && removed == 0
        return ''
    endif
    return printf(' +%d ~%d -%d', added, modified, removed)
endfunction

autocmd User Flags call Hoist("buffer", "GitGutterFlag")


" RUST 
function! SetupRust()
    let g:rustfmt_autosave = 1
    let g:rustfmt_fail_silently = 1

    nnoremap <buffer> <leader>b :Dispatch cargo build<CR>
    nnoremap <buffer> <leader>r :Dispatch cargo run<CR>
    nnoremap <buffer> <leader>t :Dispatch cargo test<CR>
endfunction

autocmd FileType rust call SetupRust()

" PYTHON
