set nu
set ai
set encoding=utf-8
syntax on
filetype plugin indent on
set hlsearch
set pumheight=10
set tabstop=4
set shiftwidth=4
set background=dark
set softtabstop=0
set completeopt=longest,menu
set nocompatible
hi Comment ctermfg=darkgrey
hi LineNr ctermfg=darkgrey
hi Constant ctermfg=Brown

let mapleader = "\<space>"

"切换回车为补全
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup complete
  autocmd!
  autocmd CompleteDone * pclose
augroup end


call plug#begin()
Plug 'voldikss/vim-translator'
call plug#end()

let g:translator_default_engines=['bing']
nmap <silent> <Leader>y <Plug>TranslateW
vmap <silent> <Leader>y <Plug>TranslateWV
