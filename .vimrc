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
set laststatus=2
set showtabline=1
set guioptions-=e
set noswapfile
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone
set belloff+=ctrlg " Add only if Vim beeps during completion
set nowritebackup
set updatetime=300
set noshowmode
set signcolumn=yes

let mapleader = "\<space>"

call plug#begin()
" ------ core ----
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'drsooch/gruber-darker-vim'
Plug 'ludovicchabant/vim-gutentags'
Plug 'yegappan/taglist'

" ------ git -----
Plug 'tpope/vim-fugitive'

" ------ tools ----
Plug 'tpope/vim-commentary'
Plug 'markonm/traces.vim'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-flagship'
Plug 'tpope/vim-sleuth'
Plug 'mhinz/vim-grepper', { 'on': ['Grepper', '<plug>(GrepperOperator)'] }
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'

" -------------- languages --------------
Plug 'mattn/emmet-vim'

call plug#end()

:colorscheme GruberDarker

let g:tokyonight_style = 'night'
let g:tokyonight_disable_italic_comment = 1
colorscheme GruberDarker


let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" copilot
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


" git

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)


" emmet

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-e>'

" ctrlp
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix']

" taglist
nnoremap <silent> <leader>tl :TlistToggle<CR>

" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
let g:gutentags_project_root = ['.root', '.svn', '.git', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" completion
nnoremap gd :YcmCompleter GoTo<cr>
nnoremap gs :YcmCompleter GoToSymbol<cr>
nnoremap gr :YcmCompleter GoToReferences<cr>
nnoremap gt :YcmCompleter GetType<cr>
nnoremap <leader>F :YcmCompleter Format<cr>
nnoremap <leader>qf :YcmCompleter FixIt<cr>
nnoremap <leader>rn :YcmCompleter RefactorRename<space>

nmap K <plug>(YCMHover)

let g:ycm_enable_diagnostic_signs = 1
let g:ycm_show_diagnostics_ui = 1
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_key_invoke_completion = '<c-j>'
let g:ycm_auto_hover = ''
let g:ycm_signature_help_disable_syntax = 1
let g:ycm_collect_identifiers_from_tags_files = 1
let g:ycm_min_num_of_chars_for_completion = 2
let g:ycm_always_populate_location_list=1
let g:ycm_show_detailed_diag_in_popup=1
let g:ycm_server_keep_logfiles = 0
let g:ycm_update_diagnostics_in_insert_mode = 0
"let g:ycm_echo_current_diagnostic = 'virtual-text'


let g:ycm_semantic_triggers =  {
  \   'c': ['->', '.', 're!^\s*#include\s',],
  \   'objc': ['->', '.', 're!\[[_a-zA-Z]+\w*\s', 're!^\s*[^\W\d]\w*\s',
  \            're!\[.*\]\s'],
  \   'ocaml': ['.', '#'],
  \   'cpp,cuda,objcpp': ['->', '.', '::'],
  \   'perl': ['->'],
  \   'php': ['->', '::'],
  \   'cs,d,elixir,go,groovy,java,javascript,julia,perl6,scala,typescript,vb': ['.'],
  \   'python': ['.', 're!^\s*import\s', 're!^\s*from\s'],
  \   'ruby,rust': ['.', '::'],
  \   'lua': ['.', ':'],
  \   'erlang': [':'],
  \ }

let g:UltiSnipsExpandTrigger="<c-m>"
let g:UltiSnipsJumpForwardTrigger="<c-m>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"
