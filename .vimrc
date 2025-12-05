vim9script

set background=dark
set pumheight=10
set nu
set ruler
set ai
set laststatus=1
set noswapfile
set cpt=.,w,b,u,t,i,o
set ac

# complete delay may 200 ms is best hahah...
set acl=100
set completeopt=popup,fuzzy
set wildoptions+=fuzzy
set shortmess+=c
set signcolumn=yes
set noshowmode
set termguicolors

# cmdline autocompletion
autocmd CmdlineChanged [:/\?] call wildtrigger()
set wildmode=noselect:lastused,full wildoptions=pum


# fuzzy-file-picker
set findfunc=Find
def Find(arg: string, _: any): list<string>
    if empty(filescache)
      filescache = globpath('.', '**', 1, 1)
      filter(filescache, (_, val) => !isdirectory(val))
      map(filescache, (_, val) => fnamemodify(val, ':.'))
    endif
    return arg == '' ? filescache : matchfuzzy(filescache, arg)
enddef
var filescache: list<string> = []
autocmd CmdlineEnter : filescache = []

# auto-complete
inoremap <silent><expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

g:mapleader = "\<space>"

# vim plug
plug#begin()
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'
Plug 'ludovicchabant/vim-gutentags'
Plug 'tmsvg/pear-tree'
Plug 'neomake/neomake'
Plug 'girishji/devdocs.vim'
Plug 'Rigellute/shades-of-purple.vim'
Plug 'vim-airline/vim-airline'
Plug 'Vimjas/vim-python-pep8-indent'
plug#end()

colorscheme shades_of_purple

# neomake
neomake#configure#automake('w')

nnoremap <leader>k :DevdocsFind<CR>
