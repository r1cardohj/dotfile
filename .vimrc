set nu
set ai
set encoding=utf-8
syntax on
filetype plugin indent on

set ignorecase
set hlsearch
set incsearch
set smartcase

set pumheight=10
set tabstop=4
set shiftwidth=4
set background=dark
set softtabstop=0
set completeopt=longest,menu,menuone,noselect
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

:nnoremap <leader>" viw<esc>a"<esc>bi"<esc>lel
:nnoremap <leader>' viw<esc>a'<esc>bi'<esc>lel


"切换回车为补全
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup complete
  autocmd!
  autocmd CompleteDone * pclose
augroup end



call plug#begin()
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'LunarWatcher/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'dense-analysis/ale' 
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'voldikss/vim-translator'
Plug 'r1cardohj/zzz.vim'
Plug 'ervandew/supertab'
if has('python3')
	Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets'
endif
Plug 'prabirshrestha/vim-lsp'
Plug 'heavenshell/vim-pydocstring', { 'do': 'make install', 'for': 'python' }
Plug 'mattn/vim-lsp-settings'
"Plug 'r1cardohj/vim-lsp-ale'
"Plug 'github/copilot.vim'
call plug#end()


function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> <leader>rn <plug>(lsp-rename)
    nmap <buffer> [g <plug>(lsp-previous-diagnostic)
    nmap <buffer> ]g <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)


    " refer to doc to add more commands
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_enabled = 0         " disable diagnostics support
let g:lsp_settings_filetype_python = 'pyright-langserver'

":colorscheme sorbet 
:colorscheme zzz
"autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
"hi Comment ctermfg=darkgrey

let g:SuperTabDefaultCompletionType = "context"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

" emmet
let g:user_emmet_leader_key='<c-e>'


" translaotr
let g:translator_default_engines = ["bing"]
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV

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
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
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
"
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


let g:ale_fixers = {'python': ['ruff']}
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint', 'vls', 'cspell'], 'python': ['ruff', 'cspell', 'pylint']}

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
