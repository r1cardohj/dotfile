vim9script

syntax on
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set ai
set hlsearch
set nocompatible
set background=dark
set pumheight=10
set mouse=a
set nu
set ruler
set laststatus=1
set noswapfile
set showmatch
set cpt+=.,w,b,u,t,i,o 

# complete delay may 200 ms is best hahah...
set completeopt+=fuzzy,noselect,menuone
set completeopt-=preview
set wildoptions+=fuzzy
set shortmess+=c
set cursorline
set relativenumber
set signcolumn=yes
set wildignore+=*.pyc,tags,*/tmp/*,*.so,*.swp,*.zip
set noshowmode
set termguicolors

g:mapleader = "\<space>"

# my plugins
plug#begin()
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-unimpaired'
Plug 'ludovicchabant/vim-gutentags'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'tpope/vim-vinegar'
Plug 'tmsvg/pear-tree'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'szw/vim-maximizer'
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'nvie/vim-flake8', {'for': 'python'}
Plug 'fatih/vim-go', {'for': 'go'}
Plug 'mattn/emmet-vim'
Plug 'Vimjas/vim-python-pep8-indent', {'for': 'python'}
Plug 'markonm/traces.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'andreasvc/vim-256noir'
plug#end()

# color Papercolor
color 256_noir

# ==================== Completion ====================
g:SuperTabDefaultCompletionType = "context"
g:SuperTabContextTextOmniPrecedence = ['&omnifunc', '&completefunc']
g:SuperTabLongestEnhanced = 1

# python

# set jedi
g:jedi#goto_command = "<leader>d"
g:jedi#goto_assignments_command = "ga"
g:jedi#goto_stubs_command = "gs"
g:jedi#goto_definitions_command = "gd"
g:jedi#documentation_command = "K"
g:jedi#usages_command = "gr"
g:jedi#rename_command = "<leader>rn"
g:jedi#popup_on_dot = 0
g:jedi#rename_command_keep_name = "<leader>R"
g:jedi#show_call_signatures = 2


# auto set venv
autocmd FileType python call SetPythonEnvironment()
autocmd FileType python map <buffer> <leader>8 :call flake8#Flake8()<CR>

def SetPythonEnvironment()
  # Get the current working directory
  var project_root = getcwd()

  # List of possible virtual environment paths (in order of priority)
  var venv_paths = [
    project_root .. '/.venv/bin/python',
    project_root .. '/venv/bin/python',
    project_root .. '/env/bin/python',
    # 如果需要，可以继续添加其他路径
  ]

  # use jedi
  g:SuperTabDefaultCompletionType = "<c-x><c-o>"

  # Check each path in order
  for venv_path in venv_paths
    if filereadable(venv_path)
      g:jedi#environment_path = venv_path
      return  # 找到第一个可用的就返回
    endif
  endfor
enddef

# ==================== vim-go ====================
g:go_fmt_fail_silently = 1
g:go_debug_windows = {
       'vars':  'leftabove 35vnew',
       'stack': 'botright 10new',
}


g:go_gopls_matcher = "fuzzy"
g:go_gopls_staticcheck = "gopls"
g:go_diagnostics_enabled = 1
g:go_test_show_name = 1

g:go_autodetect_gopath = 1

g:go_gopls_complete_unimported = 1
g:go_gopls_gofumpt = 1

# 2 is for errors and warnings
g:go_diagnostics_level = 2
g:go_doc_popup_window = 1
g:go_doc_balloon = 1

g:go_imports_mode = "gopls"
g:go_imports_autosave = 1

g:go_highlight_build_constraints = 1
g:go_highlight_operators = 1

g:go_fold_enable = []
