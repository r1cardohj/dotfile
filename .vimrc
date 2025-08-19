" ---------------- MODE -------------------
" lite mode will never use lsp
let g:lite_mode = 0
" -----------------------------------------

set nu
set ai

set encoding=utf-8
syntax on
filetype plugin indent on

set ignorecase
set hlsearch
set incsearch
set smartcase
"set cursorline
set noswapfile
set showmode
set showcmd
set title
set ruler
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
set completeopt=menu,menuone,noselect,noinsert
set nocompatible
set mouse=a
set nobackup
set nowritebackup
"set termguicolors
set updatetime=300
"set signcolumn=yes
set laststatus=2
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
  Plug 'LunarWatcher/auto-pairs'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'mattn/emmet-vim'
  Plug 'voldikss/vim-translator'
  Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
  Plug 'sheerun/vim-polyglot'
  Plug 'markonm/traces.vim'
  Plug 'Valloric/ListToggle'
  Plug 'dense-analysis/ale'
  Plug 'github/copilot.vim', {'on': ['Copilot']}
  Plug 'tomasr/molokai'
  if g:lite_mode
    Plug 'lifepillar/vim-mucomplete'
    Plug 'davidhalter/jedi-vim', {'for': 'python'}
  else
    Plug 'ycm-core/YouCompleteMe'
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'
    Plug 'preservim/tagbar'
  endif
call plug#end()


" ------------------------------- coding ------------------------------------

" completion and lsp

" --------python settings ---------
" if lite mode, we use jedi-vim
if g:lite_mode
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
endif



" ---------complete mode -----------

if g:lite_mode

  let g:mucomplete#enable_auto_at_startup = 1
  let g:mucomplete#completion_delay = 200
else
  nnoremap gd :YcmCompleter GoTo<cr>
  nnoremap gs :YcmCompleter GoToSymbol<cr>
  nnoremap gr :YcmCompleter GoToReferences<cr>
  nnoremap gt :YcmCompleter GetType<cr>
  nnoremap <leader>f :YcmCompleter FixIt<cr>
  nnoremap <leader>rn :YcmCompleter RefactorRename<space>

  nmap K <plug>(YCMHover)

  let g:ycm_enable_diagnostic_signs = 1
  let g:ycm_show_diagnostics_ui = 1
  let g:ycm_enable_diagnostic_highlighting = 1
  let g:ycm_key_invoke_completion = '<c-j>'
  let g:ycm_auto_hover = ''
  let g:ycm_signature_help_disable_syntax = 1
  let g:ycm_collect_identifiers_from_tags_files = 1
  let g:ycm_min_num_of_chars_for_completion = 2
  let g:ycm_always_populate_location_list=1
  let g:ycm_show_detailed_diag_in_popup=1
  let g:ycm_server_keep_logfiles = 0
  let g:ycm_update_diagnostics_in_insert_mode = 0
  let g:ycm_echo_current_diagnostic = 'virtual-text'


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
endif

" tagbar
nmap <leader>tb :TagbarToggle<CR>


" ale

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
let g:ale_linters = {'python': ['ruff']}

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1


" emmet
let g:user_emmet_leader_key='<c-e>'

" copilot
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true


" translaotr
let g:translator_default_engines = ["bing"]
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV

" flake8
autocmd FileType python map <buffer> gl :call flake8#Flake8()<CR>
let g:no_flake8_maps = 1
nnoremap <leader>d :call flake8#Flake8ShowError()<cr>
let g:flake8_show_in_gutter = 1


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

"html/xml
set matchpairs+=<:>     " specially for html
autocmd BufRead,BufNewFile *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2


" ------------------------- UI ----------------------------


let g:python_highlight_all = 1

" STATUSLINE MODE
let g:currentmode={
 \ 'n' : 'THINK',
 \ 'v' : 'VISUAL ',
 \ 'V' : 'V-LINE ',
 \ 'i' : 'CODING',
 \ 'R' : 'R ',
 \ 'Rv' : 'V-REPLACE ',
 \ 'c' : 'COMMAND ',
 \}

set statusline=
"set statusline+=%#Icon#
"set statusline+=\ 💤
set statusline+=\ %#NormalC#%{(mode()=='n')?'\ NORMAL\ ':''}
set statusline+=%#InsertC#%{(mode()=='i')?'\ INSERT\ ':''}
set statusline+=%#VisualC#%{(mode()=='v')?'\ VISUAL\ ':''}
set statusline+=%#CommandC#%{(mode()=='c')?'\ COMMAND\ ':''}
set statusline+=%#Filename#
set statusline+=\ %<%f\       " 显示相对路径, 用%<截断显示
set statusline+=%#ReadOnly#
set statusline+=\ %r
set statusline+=%{fugitive#statusline()}
set statusline+=W\ %{youcompleteme#GetWarningCount()}\ 
set statusline+=E\ %{youcompleteme#GetErrorCount()}\ 
" set statusline+=%{LinterStatus()}
set statusline+=%m
set statusline+=%=
set statusline+=%#LineCol#
set statusline+=\ \ %l/%L\ \ %c\
set statusline+=%#FileType#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ [%{&fileformat}]
set statusline+=%#Position#

hi LineNr ctermfg=darkgrey guifg=darkgrey
hi Constant ctermfg=Brown guifg=Brown
"hi String ctermfg=Brown guifg=Brown
highlight Comment guifg=grey ctermfg=grey

"hi Normal guifg=white guibg=black ctermbg=black

if has('gui_running')
    set pumblend=15
endif


let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']


"------------------------- UTILS -------------------------------

" Sudo write with :w!!
if executable('sudo') && executable('tee')
  command! SUwrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif

