set nu
set ai

set encoding=utf-8
syntax on
filetype plugin indent on

set ignorecase
set hlsearch
set ruler
set incsearch
set background=dark
set pumheight=10
set noswapfile
set omnifunc=syntaxcomplete#Complete
set completeopt=menu,menuone
set belloff+=ctrlg " Add only if Vim beeps during completion
set nowritebackup
set updatetime=300
set noshowmode

let mapleader = "\<space>"

colorscheme lunaperche

call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
Plug 'vim-airline/vim-airline'
Plug 'tpope/vim-commentary'
Plug 'markonm/traces.vim'
Plug 'dense-analysis/ale'
Plug 'fatih/vim-go'
Plug 'ervandew/supertab'
Plug 'milkypostman/vim-togglelist'
Plug 'SirVer/ultisnips'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
call plug#end()

" ==================== Completion + Snippet ====================
" Ultisnips has native support for SuperTab. SuperTab does omnicompletion by
" pressing tab. I like this better than autocompletion, but it's still fast.
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabLongestEnhanced = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" completion

" let g:mucomplete#enable_auto_at_startup = 1
" let g:mucomplete#completion_delay = 200


" ale config

let g:ale_lint_delay = 5000
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
let g:ale_virtualtext_cursor = 'current'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_disable_lsp = 1
nnoremap <leader>F :ALEFix<CR>
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format', 'isort']}
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {'python': ['ruff', 'pylint']}

" python support

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
endif

" auto set venv
autocmd FileType python call SetPythonEnvironment()

function! SetPythonEnvironment()

	" use jedi
	let g:SuperTabDefaultCompletionType = "<c-x><c-o>"

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

" leaderf
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0, 'File': 0, 'Buffer': 0}
let g:Lf_PopupHeight = 0.3

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fg :<C-U><C-R>=printf("Leaderf rg %s", "")<CR><CR>

" ==================== vim-go ====================
let g:go_fmt_fail_silently = 1
let g:go_debug_windows = {
      \ 'vars':  'leftabove 35vnew',
      \ 'stack': 'botright 10new',
\ }


let g:go_gopls_matcher = "fuzzy"
let g:go_gopls_staticcheck = "gopls"
let g:go_diagnostics_enabled = 0
let g:go_test_show_name = 1

let g:go_autodetect_gopath = 1

let g:go_gopls_complete_unimported = 1
let g:go_gopls_gofumpt = 1

" 2 is for errors and warnings
let g:go_diagnostics_level = 2
let g:go_doc_popup_window = 1
let g:go_doc_balloon = 1

let g:go_imports_mode="gopls"
let g:go_imports_autosave=1

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1

let g:go_fold_enable = []

nmap <script> <silent> <leader>l :call ToggleLocationList()<CR>
nmap <script> <silent> <leader>q :call ToggleQuickfixList()<CR>
