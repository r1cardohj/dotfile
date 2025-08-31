local vim = vim
local Plug = vim.fn['plug#']

vim.g.mapleader = ' '
vim.g.background = "dark"
vim.wo.number = true
vim.opt.swapfile = false


-- #### plugin ####

vim.call('plug#begin')

-- core
Plug('neovim/nvim-lspconfig')
Plug('nvim-treesitter/nvim-treesitter')
Plug('mason-org/mason.nvim')
Plug('mason-org/mason-lspconfig.nvim')
Plug('folke/which-key.nvim')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-mini/mini.nvim', {['branch'] = 'stable'})

-- tool
Plug('nmac427/guess-indent.nvim')
Plug('windwp/nvim-autopairs')
Plug('nvimdev/lspsaga.nvim')
Plug('smjonas/inc-rename.nvim')
Plug('tpope/vim-fugitive')
Plug('lewis6991/gitsigns.nvim')


-- completion stuff
Plug('saghen/blink.cmp', {['tag'] = 'v1.6.0'})

-- ui
Plug('dgagn/diagflow.nvim')
Plug ('ellisonleao/gruvbox.nvim')
Plug ('folke/tokyonight.nvim')

vim.call('plug#end')

-- enable all core

-- This is your opts table
require("telescope").setup {}
require('mini.starter').setup()
require('mini.files').setup()
require("inc_rename").setup()
require('mini.tabline').setup()
require('gitsigns').setup()
require('nvim-autopairs').setup({
  disable_filetype = { "TelescopePrompt" , "vim" },
})
vim.cmd('silent! colorscheme tokyonight-storm')
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
require('mini.basics').setup({
	  -- Options. Set field to `false` to disable.
  options = {
    -- Basic options ('number', 'ignorecase', and many more)
    basic = true,

    -- Extra UI features ('winblend', 'listchars', 'pumheight', ...)
    extra_ui = true,

    -- Presets for window borders ('single', 'double', ...)
    win_borders = 'default',
  },

  -- Mappings. Set field to `false` to disable.
  mappings = {
    -- Basic mappings (better 'jk', save with Ctrl+S, ...)
    basic = false,

    -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
    -- Supply empty string to not create these mappings.
    option_toggle_prefix = [[\]],

    -- Window navigation with <C-hjkl>, resize with <C-arrow>
    windows = false,

    -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
    move_with_alt = false,
  },

  -- Autocommands. Set field to `false` to disable
  autocommands = {
    -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
    basic = true,

    -- Set 'relativenumber' only in linewise and blockwise Visual mode
    relnum_in_visual_mode = false,
  },

  -- Whether to disable showing non-error feedback
  silent = false,
})
require('guess-indent').setup{}



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

-- completion

require('blink.cmp').setup ({
  keymap = {
    preset = 'super-tab' },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    -- (Default) Only show the documentation popup when manually triggered
    completion = { documentation = { auto_show = false } },

    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
    },

    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    --
    -- See the fuzzy documentation for more information
    fuzzy = { implementation = "prefer_rust_with_warning" }
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
  { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File", mode = "n" },
  { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc= "Live Grep", mode = "n"},
  { "<leader>fb", "<cmd>Telescope buffers<cr>", desc="Buffers", mode = "n"},
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
  { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code Action", mode='n'},
})

kb.add({
  { "gd", "<cmd>Lspsaga goto_definition<cr>", desc = "Go to Def", mode="n"},
  { "gt", "<cmd>Lspsaga goto_type_definition<cr>", desc = "Go to Def", mode="n"},
  { "gi", "<cmd>Lspsaga finder impl<cr>", desc="Go to impl", mode="n"},
  { "gr", "<cmd>Lspsaga finder ref<cr>", desc="Go to refs", mode="n"},
  { "gpd", "<cmd>Lspsaga peek_definition<cr>", desc="Go to Peek Def", mode="n"},
  { "gpt", "<cmd>Lspsaga peek_type_definition<cr>", desc="Go to Peek Type Def", mode="n"},
})

kb.add({
  { "[d", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Prev diagnostics", mode='n'},
  { "]d", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Next diagnostics", mode='n'},
})

kb.add({
  { "<leader>t", group = "toggle"},
  { "<leader>tt", "<cmd>Lspsaga term_toggle<cr>", desc="toggle terminal", mode="n"}
})
