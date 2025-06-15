set nu
set ai
set encoding=utf-8
syntax on
filetype plugin indent on

set ignorecase
set hlsearch
set incsearch
set smartcase
set noswapfile

set pumheight=10
set autoread
set backspace=indent,eol,start
set showcmd
set tabstop=4
set shiftwidth=4
set background=dark
set softtabstop=0
set completeopt=menu,menuone
set nocompatible
set mouse=a
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set laststatus=2
set termguicolors
set omnifunc=syntaxcomplete#Complete

"hi Comment ctermfg=darkgrey
"hi LineNr ctermfg=darkgrey
"hi Constant ctermfg=Brown

let mapleader = "\<space>"

" shortcut
:iabbrev @@ houjun447@gmail.com

" !!<space> create python main function
autocmd BufEnter *.py :iabbrev !! if __name__ == '__main__':<cr>
autocmd BufNewFile,BufRead *.rs set filetype=rust


:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel


augroup complete
  autocmd!
  autocmd CompleteDone * pclose
augroup end




call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'LunarWatcher/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'vim-scripts/IndexedSearch'
Plug 'tpope/vim-fugitive'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'voldikss/vim-translator'
Plug 'voldikss/vim-browser-search'
Plug 'r1cardohj/zzz.vim'
Plug 'ervandew/supertab'
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
if has('python3')
	Plug 'davidhalter/jedi-vim', {'for': 'python'}
    Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
endif
Plug 'github/copilot.vim'
Plug 'DanBradbury/copilot-chat.vim', { 'on': ['CopilotChatOpen', 'CopilotChatAddSelection'] }
call plug#end()


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
	let g:jedi#goto_command = ""
	let g:jedi#goto_assignments_command = "gr"
	let g:jedi#goto_stubs_command = "gs"
	let g:jedi#goto_definitions_command = "gd"
	let g:jedi#documentation_command = "K"
	let g:jedi#usages_command = "<leader>n"
	let g:jedi#rename_command = "<leader>rn"
	let g:jedi#rename_command_keep_name = "<leader>R"
	let g:jedi#popup_select_first = 0
	autocmd FileType python call SetJediEnvironment()
    autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
endif


":colorscheme sorbet
:colorscheme zzz
"autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
"hi Comment ctermfg=darkgrey


" supertab completion
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1


" vim-go

let g:go_test_show_name = 1
let g:go_list_type = "quickfix"

let g:go_diagnostics_level = 2
let g:go_doc_popup_window = 1
let g:go_autodetect_gopath = 1
let g:go_imports_mode="gopls"
let g:go_imports_autosave=1

let g:go_highlight_build_constraints = 1
let g:go_highlight_operators = 1

let g:go_fold_enable = []


" rust lsp use ale inner
function! Enable_rust_lsp()
    let g:ale_disable_lsp = 'auto'
    nmap gd :ALEGoToDefinition<CR>
    nmap gr :ALEFindReferences<CR>
    nmap gi :ALEGoToImplementation<CR>
    nmap gs :ALESymbolSearch<CR>
    nmap K :ALEHover<CR>
    nmap <leader>rn :ALERename<CR>
    nmap <leader>ca :ALECodeAction<CR>
    set omnifunc=ale#completion#OmniFunc
    let g:ale_linters = {'rust': ['analyzer', 'cargo']}
    let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
endfunction

autocmd FileType rust call Enable_rust_lsp()


" emmet
let g:user_emmet_leader_key='<c-e>'

" copilot
" Open a new Cpilot Chat window
nnoremap <leader>cc :CopilotChatOpen<CR>

" Add visual selection to copilot window
vmap <leader>cc <Plug>CopilotChatAddSelection

imap <silent><script><expr> <C-j> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true

" translaotr
let g:translator_default_engines = ["bing"]
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV

" browser-search
nmap <silent> <Leader>s <Plug>SearchNormal
vmap <silent> <Leader>s <Plug>SearchVisual

" git blame
nnoremap <Leader>gb :<C-u>BlamerToggle<CR>
let g:blamer_show_in_insert_mode = 0
let g:blamer_show_in_visual_mode = 0
let g:blamer_delay = 3000

" git gitgutter
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plugh(GitGutterPrevHunk)
nmap <leader>hw <Plug>(GitGutterStageHunk)
nmap <leader>hx <Plug>(GitGutterUndoHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)
nmap <leader>hd <Plug>(GitGutterDiffOrig)


" nerdtree
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif




"fzf
let g:fzf_vim = {}
let g:fzf_vim.buffers_jump = 1
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
nnoremap <Leader>bf :<C-u>Buffers<CR>
nnoremap <silent> <C-p>          :<c-u>Files<CR>
nnoremap <silent> <space>fg      :<c-u>Rg<CR>


" ale config

let g:ale_lint_delay = 1000
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1
nnoremap <leader>F :ALEFix<CR>
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format', 'isort']}
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint', 'vls'], 'python': ['ruff']}


function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '🟨 %d 🟥 %d',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

"STATUSLINE MODE
let g:currentmode={
 \ 'n' : 'NORMAL ',
 \ 'v' : 'VISUAL ',
 \ 'V' : 'V-LINE ',
 \ 'i' : 'INSERT ',
 \ 'R' : 'R ',
 \ 'Rv' : 'V-REPLACE ',
 \ 'c' : 'COMMAND ',
 \}

set statusline=
set statusline+=%#Icon#
set statusline+=\ 💤
set statusline+=\ %#NormalC#%{(mode()=='n')?'\ NORMAL\ ':''}
set statusline+=%#InsertC#%{(mode()=='i')?'\ INSERT\ ':''}
set statusline+=%#VisualC#%{(mode()=='v')?'\ VISUAL\ ':''}
set statusline+=%#Filename#
set statusline+=\ %f
set statusline+=%#ReadOnly#
set statusline+=\ %r
set statusline+=%{fugitive#statusline()}
set statusline+=%{LinterStatus()}
set statusline+=%m
set statusline+=%=
set statusline+=\ %l\:%L
set statusline+=%#Fileformat#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}\]
set statusline+=%#Position#

let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 200
let g:matchup_matchparen_deferred_hide_delay = 700
:hi MatchParen ctermbg=blue guibg=NONE guifg=#FBB1F9
