--- config start -----

local vim = vim
local Plug = vim.fn['plug#']

vim.g.mapleader = ' '
vim.g.background = 'dark'
vim.g.ai_cmp = true
vim.wo.number = true
vim.opt.swapfile = false
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.tabstop = 4
vim.opt.signcolumn = 'yes'
vim.opt.softtabstop = 4
vim.opt.completeopt = { 'menuone', 'longest', 'preview'}
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.updatetime = 300
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.showmode = false
vim.opt.wildignore:append({
  '*.pyc',
  '*.pyo',
  '*/__pycache__',
  '*/__pycache__/*',
  '*.so',
})
vim.wo.relativenumber = true



-- #### plugin ####

vim.call('plug#begin')

-- core
Plug('neovim/nvim-lspconfig')
Plug('nvim-treesitter/nvim-treesitter')
Plug('mason-org/mason.nvim')
Plug('mason-org/mason-lspconfig.nvim')
Plug('folke/which-key.nvim')
Plug('nvim-mini/mini.nvim', {['branch'] = 'stable'})

-- tool
Plug('nmac427/guess-indent.nvim')
Plug('windwp/nvim-autopairs')
Plug('nvimdev/lspsaga.nvim')
Plug('smjonas/inc-rename.nvim')
Plug('tpope/vim-fugitive')
Plug('lewis6991/gitsigns.nvim')


-- complete
Plug('neovim/nvim-lspconfig')
Plug('hrsh7th/cmp-nvim-lsp')
Plug('hrsh7th/cmp-buffer')
Plug('hrsh7th/cmp-path')
Plug('hrsh7th/cmp-cmdline')
Plug('hrsh7th/nvim-cmp')
Plug('ray-x/lsp_signature.nvim')


-- ui
Plug('dgagn/diagflow.nvim')
Plug('ellisonleao/gruvbox.nvim')
Plug('folke/tokyonight.nvim')

vim.call('plug#end')

-- enable all core

require('mini.starter').setup()
require "lsp_signature".setup({
  bind = true,
  handler_opts = {
    border = "rounded"
  }
})

require('mini.pick').setup()
require('mini.snippets').setup()
require("inc_rename").setup()
require('mini.tabline').setup()
require('gitsigns').setup()
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
vim.cmd('silent! colorscheme tokyonight')
require("mason").setup({
	ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})
require("mason-lspconfig").setup()
require('diagflow').setup({
    enable = true,
    max_width = 60,  -- The maximum width of the diagnostic messages
    max_height = 10, -- the maximum height per diagnostics
    severity_colors = {  -- The highlight groups to use for each diagnostic severity level
        error = "DiagnosticFloatingError",
        warning = "DiagnosticFloatingWarn",
        info = "DiagnosticFloatingInfo",
        hint = "DiagnosticFloatingHint",
    },
    format = function(diagnostic)
      return diagnostic.message
    end,
    gap_size = 1,
    scope = 'line', -- 'cursor', 'line' this changes the scope, so instead of showing errors under the cursor, it shows errors on the entire line.
    padding_top = 0,
    padding_right = 0,
    text_align = 'right', -- 'left', 'right'
    placement = 'top', -- 'top', 'inline'
    inline_padding_left = 0, -- the padding left when the placement is inline
    update_event = { 'DiagnosticChanged', 'BufReadPost' }, -- the event that updates the diagnostics cache
    toggle_event = { }, -- if InsertEnter, can toggle the diagnostics on inserts
    show_sign = false, -- set to true if you want to render the diagnostic sign before the diagnostic message
    render_event = { 'DiagnosticChanged', 'CursorMoved' },
    border_chars = {
      top_left = "┌",
      top_right = "┐",
      bottom_left = "└",
      bottom_right = "┘",
      horizontal = "─",
      vertical = "│"
    },
    show_borders = false,
})
require('mini.statusline').setup({
  content = {
    -- Content for active window
    active = nil,
    -- Content for inactive window(s)
    inactive = nil,
  },

  -- Whether to use icons by default
  use_icons = false,
})
require('mini.pairs').setup()
require('mini.icons').setup()
require('guess-indent').setup{}

-- files
require('mini.files').setup({
  windows = {
    width_focus = 30,
    width_preview = 30,
  }
})

-- treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the listed parsers MUST always be installed)
  ensure_installed = { "c", "lua","markdown", "markdown_inline", "python", "go" },

  highlight = {
    enable = true,
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    additional_vim_regex_highlighting = false,
  },
}

-- completion stuff
local cmp = require'cmp'

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end


local ts_utils = require('nvim-treesitter.ts_utils')

local function is_in_string()
  local node = ts_utils.get_node_at_cursor()
  while node do
    if node:type() == "string" or node:type() == "string_literal" then
      return true
    end
    node = node:parent()
  end
  return false
end

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)

      -- For `mini.snippets` users:
      -- local insert = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
      -- insert({ body = args.body }) -- Insert at cursor
      -- cmp.resubscribe({ "TextChangedI", "TextChangedP" })
      -- require("cmp.config").set_onetime({ sources = {} })
    end,
  },
  completion = {
    keyword_length = 1,
    autocomplete = false,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.abort(),
    ['<Tab>'] = cmp.mapping(function(fallback)
        if cmp.visible() then
          -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
          cmp.select_next_item()
        elseif vim.snippet.active({ direction = 1 }) then
          vim.schedule(function()
            vim.snippet.jump(1)
          end)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif vim.snippet.active({ direction = -1 }) then
          vim.schedule(function()
            vim.snippet.jump(-1)
          end)
        else
          fallback()
        end
      end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    --{ name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
  }, {
    { name = 'buffer' },
  })
})

-- auto trigger in input.
vim.api.nvim_create_autocmd('TextChangedI', {
  pattern = '*',
  callback = function()
    local col = vim.fn.col('.') - 1
    local line = vim.fn.getline('.')
    if col > 0 and line:sub(col, col) == '.' and not is_in_string() then
      require('cmp').complete()
    end
  end,
})


-- lsp

require('lspsaga').setup({
  symbol_in_winbar = {
    enable = false
  },
  rename = {
    key = {
      quit = '<esc>'
    }
  }
})

-- which-key and my key-binding
local kb = require("which-key")

vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<cr>')

kb.add({
  { "<leader>f", group = "file" }, -- group
  { "<leader>ff", "<cmd>Pick files <cr>", desc = "Find File", mode = "n" },
  { "<leader>fg", "<cmd>Pick grep_live<cr>", desc= "Live Grep", mode = "n"},
  { "<leader>fb", "<cmd>Pick buffers<cr>", desc="Buffers", mode = "n"},
})

kb.add({
  { "<leader>r", group="Re-things"},
  { "<leader>rn", ":IncRename ", desc = "Rename", mode = "n"}
})

kb.add({
  { "<leader>e", "<cmd>lua MiniFiles.open()<cr>", desc = "Files Explore", mode="n"}
})

kb.add({
  { "<leader>c", group = "Code(lsp)"},
  { "<leader>ca", "<cmd>Lspsaga ode_action<cr>", desc = "Code Action", mode='n'},
})

kb.add({
  { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to Def", mode="n"},
  { "gt", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Go to Def", mode="n"},
  { "gi", "<cmd>Lspsaga finder impl<cr>", desc="Go to impl", mode="n"},
  { "gr", "<cmd>Lspsaga finder ref<cr>", desc="Go to refs", mode="n"},
  { "gpd", "<cmd>Lspsaga peek_definition<cr>", desc="Go to Peek Def", mode="n"},
  { "gpt", "<cmd>Lspsaga peek_type_definition<cr>", desc="Go to Peek Type Def", mode="n"},
})

local gitsigns = require('gitsigns')

kb.add({
  { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Prev diagnostics", mode='n'},
  { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostics", mode='n'},
  { "[h",
    function ()
      if vim.wo.diff then
        vim.cmd.normal({']h', bang = true})
      else
        gitsigns.nav_hunk('prev')
      end
    end,
    desc = "Prev Hunk(git)",
    mode = 'n'
  },
  { "]h",
    function ()
      if vim.wo.diff then
        vim.cmd.normal({']h', bang = true})
      else
        gitsigns.nav_hunk('next')
      end
    end,
    desc = "Next Hunk(git)",
    mode = 'n'
  }
})

kb.add({
  { "<leader>t", group = "toggle"},
  { "<leader>tt", "<cmd>Lspsaga term_toggle<cr>", desc="toggle terminal", mode="n"},
  { "<leader>td", group = "diagnostic"},
  { "<leader>tdb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc="toggle buffer diagnostic", mode="n"},
  { "<leader>tdw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc="toggle workspace diagnostic", mode="n"},
  { "<leader>tg", group = "git"},
  { "<leader>tgb", gitsigns.toggle_current_line_blame, desc="toggle git blame", mode="n"},
  { "<leader>tgw", gitsigns.toggle_word_diff, desc="toggle git word diff", mode="n"}
})

kb.add({
  { "<leader>h", group = "Git Hunk"},
  { "<leader>hs", gitsigns.stage_hunk, desc="Stage hunk", mode="n"},
  { "<leader>hr", gitsigns.reset_hunk, desc="Reset hunk", mode="n"},
  { "<leader>hs", function ()
    gitsigns.stage_hunk({ vim.fn.line('.'), vim.fn.line('v')})
  end, desc="Stage hunk", mode="v"},
  { "<leader>hr", function ()
    gitsigns.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
  end, desc="Reset hunk", mode="v"},
  { "<leader>hS", gitsigns.stage_buffer, desc="Stage buffer", mode="n"},
  { "<leader>hR", gitsigns.reset_buffer, desc="Reset buffer", mode="n"},
  { "<leader>hp", gitsigns.preview_hunk_inline, desc='Preview hunk', mode="n"},
  { "<leader>hb", function ()
    gitsigns.blame_line({ full = true })
  end, desc="Git Blame", mode="n"},
  { "<leader>hd", gitsigns.diffthis, desc="Diff this", mode="n"},
  { "<leader>hD", function ()
    gitsigns.diffthis('~')
  end, desc="Diff this(D)", mode="n"},
  { "<leader>hq", gitsigns.setqflist, desc="Git qflist", mode="n"},
  { "<leader>hQ", function ()
    gitsigns.setqflist('all')
  end, desc="Git qflist(all)", mode="n"},
})
