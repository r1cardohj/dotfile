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
Plug 'ervandew/supertab'
Plug 'dense-analysis/ale'
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

" -------------- languages --------------
Plug 'mattn/emmet-vim'
Plug 'davidhalter/jedi-vim'

call plug#end()

:colorscheme GruberDarker

" emmet

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-e>'


" ale

let g:ale_lint_delay = 3000
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
let g:ale_virtualtext_cursor = 'current'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_completion_enabled = 1
let g:ale_disable_lsp = 1
nnoremap <leader>F :ALEFix<CR>
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format', 'isort']}
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {'python': ['ruff']}

function! SetJediEnvironment()
  " Get the current working directory
  let l:project_root = getcwd()

  " Path to the virtual environment Python interpreter
  let l:venv_python = l:project_root . '/.venv/bin/python'
  let l:venv2_python = l:project_root . '/venv/bin/python'
  let l:venv3_python = l:project_root . '/env/bin/python'


  " Check if the .venv directory exists
  if filereadable(l:venv_python)
    " If .venv exists, use its Python interpreter
    let g:jedi#environment_path = l:venv_python
  endif

  if filereadable(l:venv2_python)
	" If venv exists, use its Python interpreter
	let g:jedi#environment_path = l:venv2_python
  endif

  if filereadable(l:venv3_python)
	" If env exists, use its Python interpreter
	let g:jedi#environment_path = l:venv3_python
  endif

endfunction

if has('python3')
	" set jedi
	let g:jedi#goto_command = "<leader>d"
	let g:jedi#goto_assignments_command = "ga"
	let g:jedi#goto_stubs_command = "gs"
	let g:jedi#goto_definitions_command = "gd"
	let g:jedi#documentation_command = "K"
	let g:jedi#usages_command = "gr"
	let g:jedi#rename_command = "<leader>rn"
	let g:jedi#rename_command_keep_name = "<leader>R"
	let g:jedi#popup_select_first = 0
  let g:jedi#popup_on_dot = 0
  let g:jedi#show_call_signatures = 2
	autocmd FileType python call SetJediEnvironment()
    autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
endif

" code completion SuperTab config
let g:SuperTabLongestEnhanced = 1
let g:SuperTabDefaultCompletionType = "context"

" ctrlp
let g:ctrlp_extensions = ['tag', 'buffertag', 'quickfix']

" taglist
nnoremap <silent> <leader>tl :TlistToggle<CR>
