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
set completeopt=menu,menuone,noselect
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
"Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
"Plug 'junegunn/fzf.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'LunarWatcher/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'preservim/nerdtree', { 'on': ['NERDTreeToggle', 'NERDTreeFind'] }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-commentary'
Plug 'mattn/emmet-vim'
Plug 'voldikss/vim-translator'
Plug 'voldikss/vim-browser-search'
Plug 'r1cardohj/zzz.vim'
Plug 'Yggdroot/indentLine'
Plug 'sheerun/vim-polyglot'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
"Plug 'antoinemadec/coc-fzf'
Plug 'github/copilot.vim'
Plug 'DanBradbury/copilot-chat.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'ryanoasis/vim-devicons'
call plug#end()


":colorscheme sorbet
:colorscheme zzz
"autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE
"hi Comment ctermfg=darkgrey

" airline

let g:airline_theme='minimalist'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'

" supertab completion
let g:SuperTabLongestEnhanced = 1


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
let g:NERDTreeGitStatusUseNerdFonts = 1



"fzf
" let g:fzf_vim = {}
" let g:fzf_vim.buffers_jump = 1
" let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
" nnoremap <Leader>bf :<C-u>Buffers<CR>
" nnoremap <silent> <C-p>          :<c-u>Files<CR>
" nnoremap <silent> <space>fg      :<c-u>Rg<CR>


let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_deferred_show_delay = 200
let g:matchup_matchparen_deferred_hide_delay = 700
:hi MatchParen ctermbg=blue guibg=NONE guifg=#FBB1F9


" coc

inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <TAB> coc#pum#visible() ? coc#pum#confirm()
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

" Formatting selected code
xmap <leader>f  <Plug>(coc-format-selected)

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

" Add (Neo)Vim's native statusline support
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" mappings
" nnoremap <silent> <space><space> :<C-u>CocFzfList<CR>
" nnoremap <silent> <space>a       :<C-u>CocFzfList diagnostics<CR>
" nnoremap <silent> <space>b       :<C-u>CocFzfList diagnostics --current-buf<CR>
" nnoremap <silent> <space>c       :<C-u>CocFzfList commands<CR>
nnoremap <silent> <space><space> :<C-u>CocList<CR>
nnoremap <silent> <space>f       :<C-u>CocList files<CR>
nnoremap <silent> <space>fg      :<C-u>CocList grep<CR>
nnoremap <silent> <space>c       :<C-u>CocList commands<CR>
nnoremap <silent> <space>d       :<C-u>CocList diagnostics<CR>
