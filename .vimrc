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
set completeopt=longest,menu
set nocompatible
set mouse=a
set nobackup
set nowritebackup
set updatetime=300
set signcolumn=yes
set laststatus=2
set termguicolors

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
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'antoinemadec/coc-fzf'
Plug 'dense-analysis/ale' 
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'voldikss/vim-translator'
Plug 'r1cardohj/zzz.vim'
call plug#end()

":colorscheme sorbet 
:colorscheme zzz
"autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
"hi Comment ctermfg=darkgrey


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
nnoremap <Leader>bf :<C-u>Buffers<CR>



" fzf config
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }


" ale config
"
let g:ale_lint_delay = 1000
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
nnoremap <leader>F :ALEFix<CR>

let g:ale_completion_enabled = 0
let g:ale_disable_lsp = 1
let g:ale_fixers = {'python': ['ruff']}
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linter_aliases = {'vue': ['vue', 'javascript']}
let g:ale_linters = {'vue': ['eslint', 'vls']}

"coc settings

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code
" xmap <leader>F  <Plug>(coc-format-selected)
" nmap <leader>F  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s)
  autocmd FileType typescript,json,python setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying code actions to the selected code block
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying code actions at the cursor position
nmap <leader>ca  <Plug>(coc-codeaction-cursor)
" Remap keys for apply code actions affect whole buffer
nmap <leader>sa  <Plug>(coc-codeaction-source)
" Apply the most preferred quickfix action to fix diagnostic on the current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap keys for applying refactor code actions
nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

" Run the Code Lens action on the current line
nmap <leader>cl  <Plug>(coc-codelens-action)

if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

command! -nargs=0 Format :call CocActionAsync('format')

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
"set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" mappings
nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
nnoremap <silent> <space>da       :<C-u>CocFzfList diagnostics<CR>
nnoremap <silent> <space>db       :<C-u>CocFzfList diagnostics --current-buf<CR>
nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <C-p>          :<c-u>Files<CR>
nnoremap <silent> <space>fg      :<c-u>Rg<CR>

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
