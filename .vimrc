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
set cpt=.,w,b,u,t,i,o
set ac
"complete delay may 200 ms is best hahah...
set acl=200 
set completeopt=popup,fuzzy,menu
set wildoptions+=fuzzy
set shortmess+=c
set signcolumn=yes
set noshowmode

let mapleader = "\<space>"

call plug#begin()
Plug 'sheerun/vim-polyglot'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'tmsvg/pear-tree'
Plug 'neomake/neomake'
call plug#end()

colorscheme habamax

" cmdline autocompletion
autocmd CmdlineChanged [:/\?] call wildtrigger()
set wildmode=noselect:lastused,full wildoptions=pum

let g:java_ignore_markdown = 1

" neomake
call neomake#configure#automake('w')

" fuzzy-file-picker
set findfunc=Find
func Find(arg, _)
    if empty(s:filescache)
      let s:filescache = globpath('.', '**', 1, 1)
      call filter(s:filescache, '!isdirectory(v:val)')
      call map(s:filescache, "fnamemodify(v:val, ':.')")
    endif
    return a:arg == '' ? s:filescache : matchfuzzy(s:filescache, a:arg)
endfunc
let s:filescache = []
autocmd CmdlineEnter : let s:filescache = []

" auto-complete
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
