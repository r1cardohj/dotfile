set nu
set ai

set encoding=utf-8
syntax on
filetype plugin indent on

set ignorecase
set hlsearch
set incsearch
set smartcase
set cursorline
set noswapfile
set scrolloff=5     " keep at least 5 lines above/below cursor
set sidescrolloff=5 " keep at least 5 columns left/right of cursor


set pumheight=10
set autoread
set wildmenu

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
set wildignore+=*/.git/*,*/tmp/*,*.swp,*.bak,*.pyc,*.pyo,*.class,*.o,*.obj,*.exe,*.dll,*.so,*.dylib
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " Add only if Vim beeps during completion



let mapleader = "\<space>"
let g:Lf_WindowPosition = 'popup'

" shortcut
:iabbrev @@ houjun447@gmail.com

" !!<space> create python main function
autocmd BufEnter *.py :iabbrev !! if __name__ == '__main__':<cr>
autocmd BufNewFile,BufRead *.rs set filetype=rust


:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel


set noshowmode


augroup complete
  autocmd!
  autocmd CompleteDone * pclose
augroup end


call plug#begin()
Plug 'ctrlpvim/ctrlp.vim'
Plug 'LunarWatcher/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'bryanmylee/vim-colorscheme-icons'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'voldikss/vim-translator'
Plug 'voldikss/vim-browser-search'
Plug 'Yggdroot/indentLine'
Plug 'r1cardohj/zzz.vim'
Plug 'shrikecode/kyotonight.vim'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'ervandew/supertab'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries', 'for': 'go' }
Plug 'github/copilot.vim', {'on': ['Copilot']}
Plug 'DanBradbury/copilot-chat.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
Plug 'markonm/traces.vim'
Plug 'lambdalisue/suda.vim'
Plug 'AndrewRadev/quickpeek.vim'
Plug 'preservim/tagbar'
call plug#end()

let g:quickpeek_auto = v:true

" ale config

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
    let g:jedi#show_call_signatures = 0
	autocmd FileType python call SetJediEnvironment()
    autocmd FileType python let g:SuperTabDefaultCompletionType = "<c-x><c-o>"
endif

" code completion SuperTab config
let g:SuperTabDefaultCompletionType = "context"
let g:SuperTabLongestEnhanced = 1

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"


" generate python docstring
nmap <silent> <leader>ds <Plug>(pydocstring)



let g:kyotonight_bold = 1
let g:kyotonight_underline = 1
let g:kyotonight_italic = 1
"let g:kyotonight_italic_comments = 1
let g:kyotonight_uniform_status_lines = 1
let g:kyotonight_cursor_line_number_background = 0
let g:kyotonight_uniform_diff_background = 1
"let g:kyotonight_lualine_bold = 1

:colorscheme kyotonight

" autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
" autocmd vimenter * hi SignColumn guibg=NONE ctermbg=NONE
" autocmd vimenter * hi LineNr guibg=NONE ctermbg=NONE
"hi Comment ctermfg=darkgrey guifg=darkgrey gui=italic cterm=italic
" hi LineNr ctermfg=darkgrey guifg=darkgrey
" hi Constant ctermfg=Brown guifg=darkgrey

" airline

"
"let g:airline_theme='minimalist'
let g:airline_theme='kyotonight'
"let g:airline_powerline_fonts = 1
"let g:airline_theme='kyotonight'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#virtualenv#enabled = 1

" ctrlp
if executable('rg')
  set grepprg=rg\ --color=never
  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" emmet
let g:user_emmet_leader_key='<c-e>'

" copilot
" Open a new Cpilot Chat window
nnoremap <leader>cc :CopilotChatOpen<CR>

" Add visual selection to copilot window
vmap <leader>cc <Plug>CopilotChatAddSelection

imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
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
let g:NERDTreeGitStatusUseNerdFonts = 1

" nerdtree git status
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'M',
                \ 'Staged'    :'S',
                \ 'Untracked' :'U',
                \ 'Renamed'   :'R',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'D',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }



" match up
let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 200
let g:matchup_matchparen_deferred_hide_delay = 700
:hi MatchParen ctermbg=blue guibg=NONE guifg=#FBB1F9

