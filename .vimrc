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
  Plug 'sheerun/vim-polyglot'
  Plug 'markonm/traces.vim'
  Plug 'github/copilot.vim', {'on': ['Copilot']}
  if g:lite_mode
    Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }
    Plug 'lifepillar/vim-mucomplete'
    Plug 'dense-analysis/ale'
    Plug 'davidhalter/jedi-vim', {'for': 'python'}
  else
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
  endif
call plug#end()


" ------------------------------- coding ------------------------------------


" ale config
" it just a linter in my conf

let g:ale_lint_delay = 5000
nmap <silent> [g <Plug>(ale_previous_wrap)
nmap <silent> ]g <Plug>(ale_next_wrap)
let g:ale_virtualtext_cursor = 'current'
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:ale_lint_on_insert_leave = 0
" default disable lsp
let g:ale_disable_lsp = 1

nnoremap <leader>F :ALEFix<CR>
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_python_pylint_use_global = 0

let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace'], 'python': ['ruff', 'ruff_format', 'isort']}
" In ~/.vim/vimrc, or somewhere similar.
let g:ale_linters = {'python': ['ruff', 'pylint']}



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
  " all in coc settings
  
  " use <tab> to trigger completion and navigate to the next complete item
  function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " with coc snippets
  inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

  let g:coc_snippet_next = '<tab>'
  let g:coc_snippet_next = '<c-j>'
  let g:coc_snippet_prev = '<c-k>'


  " Use <c-space> to trigger completion
  if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
  else
    inoremap <silent><expr> <c-@> coc#refresh()
  endif

  " Use `[g` and `]g` to navigate diagnostics
  " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
  nmap <silent><nowait> [g <Plug>(coc-diagnostic-prev)
  nmap <silent><nowait> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent><nowait> gd <Plug>(coc-definition)
  nmap <silent><nowait> gy <Plug>(coc-type-definition)
  nmap <silent><nowait> gi <Plug>(coc-implementation)
  nmap <silent><nowait> gr <Plug>(coc-references)

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
  xmap <leader>F  <Plug>(coc-format-selected)
  nmap <leader>F  <Plug>(coc-format-selected)

  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s)
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  augroup end

  " Applying code actions to the selected code block
  " Example: `<leader>aap` for current paragraph
  xmap <leader>a  <Plug>(coc-codeaction-selected)
  nmap <leader>a  <Plug>(coc-codeaction-selected)

  " Remap keys for applying code actions at the cursor position
  nmap <leader>ac  <Plug>(coc-codeaction-cursor)
  " Remap keys for apply code actions affect whole buffer
  nmap <leader>as  <Plug>(coc-codeaction-source)
  " Apply the most preferred quickfix action to fix diagnostic on the current line
  nmap <leader>qf  <Plug>(coc-fix-current)

  " Remap keys for applying refactor code actions
  nmap <silent> <leader>re <Plug>(coc-codeaction-refactor)
  xmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)
  nmap <silent> <leader>r  <Plug>(coc-codeaction-refactor-selected)

  " Run the Code Lens action on the current line
  nmap <leader>cl  <Plug>(coc-codelens-action)

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  " Remap <C-f> and <C-b> to scroll float windows/popups
  if has('nvim-0.4.0') || has('patch-8.2.0750')
    nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
    inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
    inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
    vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
    vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  endif

  " Use CTRL-S for selections ranges
  " Requires 'textDocument/selectionRange' support of language server
  nmap <silent> <C-s> <Plug>(coc-range-select)
  xmap <silent> <C-s> <Plug>(coc-range-select)

  " Add `:Format` command to format current buffer
  command! -nargs=0 Format :call CocActionAsync('format')

  " Add `:Fold` command to fold current buffer
  command! -nargs=? Fold :call     CocAction('fold', <f-args>)

  " Add `:OR` command for organize imports of the current buffer
  command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')


  " Mappings for CoCList
  nnoremap <silent><nowait> <space><space> : <C-u>CocList<cr>

  nnoremap <silent><nowait> <space>ff  :<C-u>CocList files<cr>
  nnoremap <silent><nowait> <space>fg :<C-u>CocList grep<cr>
  nnoremap <silent><nowait> <space>fb :<C-u>CocList buffer<cr>
  " Show all diagnostics
  nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
  " Show commands
  nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
  " Find symbol of current document
  nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols
  nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
  " Do default action for next item
  nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item
  nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
endif



" emmet
let g:user_emmet_leader_key='<c-e>'

" copilot
imap <silent><script><expr> <C-l> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
nnoremap <leader>cc :CopilotChatOpen<CR>
vmap <leader>cc <Plug>CopilotChatAddSelection

" translaotr
let g:translator_default_engines = ["bing"]
nmap <silent> <Leader>w <Plug>TranslateW
vmap <silent> <Leader>w <Plug>TranslateWV


" leaderf
if g:lite_mode
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
endif

"html/xml
set matchpairs+=<:>     " specially for html
autocmd BufRead,BufNewFile *.htm,*.html,*.css setlocal tabstop=2 shiftwidth=2 softtabstop=2


" ------------------------- UI ----------------------------

let g:python_highlight_all = 1

" augroup illuminate_augroup
"     autocmd!
"     autocmd VimEnter * hi illuminatedWord cterm=bold gui=bold
" augroup END

" LinterStatus function (unchanged)
function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   'W(%d) E(%d)',
    \   all_non_errors,
    \   all_errors
    \)
endfunction

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
if g:lite_mode
  set statusline+=%{LinterStatus()}
else
  set statusline+=%{coc#status()}%{get(b:,'coc_current_function','')}
endif
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


let g:ale_sign_error = '●'
let g:ale_sign_warning = '●'
let g:ale_sign_info = '●'
hi ALEWarning gui=underline cterm=underline
hi ALEInfo   gui=underline cterm=underline
hi ALEError  gui=underline cterm=underline
hi ALEWarningSign cterm=none   ctermbg=none    ctermfg=yellow     gui=none   guifg=#FFE377
hi ALEErrorSign   cterm=none   ctermbg=none    ctermfg=red     gui=none   guifg=#F75646
hi ALEInfoSign    cterm=none   ctermbg=none    ctermfg=grey     gui=none   guifg=#B0B0B0

if has('gui_running')
    set pumblend=15
endif

hi CocSearch guifg=NONE guibg=NONE ctermfg=yellow

"let g:completion_matching_strategy_list = ['exact', 'substring']


"------------------------- UTILS -------------------------------

" Sudo write with :w!!
if executable('sudo') && executable('tee')
  command! SUwrite
        \ execute 'w !sudo tee % > /dev/null' |
        \ setlocal nomodified
endif

