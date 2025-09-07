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
"set termguicolors

let mapleader = "\<space>"

call plug#begin()
" ------ core ----
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'ervandew/supertab'
Plug 'ludovicchabant/vim-gutentags'
Plug 'prabirshrestha/vim-lsp'
"Plug 'dense-analysis/ale'

" ------ git -----
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" ------ ui -----
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'mhinz/vim-startify'
Plug 'vim-airline/vim-airline'

" ------ tools ----
Plug 'raimondi/delimitmate'
Plug 'tpope/vim-commentary'
Plug 'markonm/traces.vim'
Plug 'github/copilot.vim'

" -------------- languages --------------
Plug 'fatih/vim-go'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets', {'for': 'python'}
Plug 'mattn/emmet-vim'

call plug#end()

let g:gruvbox_italic=1
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection=0


colorscheme gruvbox

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" ==================== Completion + Snippet ====================
" Ultisnips has native support for SuperTab. SuperTab does omnicompletion by
" pressing tab. I like this better than autocompletion, but it's still fast.
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
let g:SuperTabLongestEnhanced = 1

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" tag and ctrlp
nmap tb :TagbarToggle<CR>

let g:ctrlp_extensions = ['tag', 'buffertag', 'line', 'quickfix']
nmap <C-q> :CtrlPQuickfix<CR>

" ale config

" let g:ale_lint_delay = 5000
" nmap <silent> [g <Plug>(ale_previous_wrap)
" nmap <silent> ]g <Plug>(ale_next_wrap)
" let g:ale_virtualtext_cursor = 'current'
" let g:ale_lint_on_text_changed = 'never'
" let g:ale_lint_on_enter = 0
" let g:ale_lint_on_insert_leave = 1
" let g:ale_disable_lsp = 1
" nnoremap <leader>F :ALEFix<CR>
" let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


" let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format', 'isort']}
" " In ~/.vim/vimrc, or somewhere similar.
" let g:ale_linters = {'python': ['ruff']}

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
		let g:jedi#popup_on_dot = 1
		let g:jedi#show_call_signatures = 2
endif

" auto set venv
autocmd FileType python call SetPythonEnvironment()

function! SetPythonEnvironment()

	" use jedi
	let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
	let l:venv_paths = ['.venv/bin/python', 'venv/bin/python', 'env/bin/python']
    for venv in l:venv_paths
			let l:venv_python = getcwd() . '/' . venv
			if filereadable(l:venv_python)
					let g:jedi#environment_path = l:venv_python
					break
			endif
	endfor

endfunction

" git

nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)



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

" lsp
function! s:on_lsp_buffer_enabled() abort
	if &filetype != "python"
    setlocal omnifunc=lsp#complete
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
	endif

    nmap <buffer> [d <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]d <plug>(lsp-next-diagnostic)
		nmap <buffer> <leader>F :LspDocumentFormat<CR>
		nmap <buffer> <leader>ca :LspCodeAction<CR>
		nmap <buffer> <leader>cl :LspCodeLens<CR>
		nmap <buffer> td :LspDocumentDiagnostics<CR>
		setlocal signcolumn=yes
    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre *.rs,*.go,*.py call execute('LspDocumentFormatSync')
    
    " refer to doc to add more commands
endfunction

let g:lsp_diagnostics_virtual_text_enabled = 0
"let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_use_native_client = 1
let g:lsp_diagnostics_highlights_insert_mode_enabled = 0
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_warning = {'text': '!!'}
let g:lsp_diagnostics_signs_warning = {'text': '??'}


if executable('zuban')
	au User lsp_setup call lsp#register_server({
			\ 'name': 'Zuban',
			\ 'cmd': ['zuban', 'server'],
			\ 'allowlist': ['python'],
			\ })
endif

if executable('ruff')
	au User lsp_setup call lsp#register_server({
			\ 'name': 'ruff',
			\ 'cmd': ['ruff', 'server'],
			\ 'allowlist': ['python'],
			\ })
endif

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall
let g:user_emmet_leader_key='<C-e>'
