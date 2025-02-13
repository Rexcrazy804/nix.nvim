-- vim options
vim.o.number = true
vim.o.termguicolors = true
vim.o.cmdheight = 0
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.cursorlineopt = "number"
vim.o.signcolumn = "yes"

vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.smartindent = true
vim.o.tabstop = 2
vim.o.softtabstop = 2

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.wrap = false

vim.o.scrolloff = 5

vim.g.mapleader = " ";

-- plugins
require("lze").load {
  {
    "catppuccin-nvim",
    colorscheme = "catppuccin",
    before = function()
      require('catppuccin').setup({
        flavour = "mocha",
        transparent_background = true,
        term_colors = true, -- check this out
      })
    end
  },

  {
    "neo-tree.nvim",
    keys = {
      { "<C-n>", "<CMD>Neotree toggle<CR>", desc = "NeoTree toggle" },
    },
    after = function()
      require("neo-tree").setup()
    end,
  },

  {
    "which-key.nvim",
    lazy = false,
    after = function()
      require("which-key").setup({
        preset = "modern",
      })
    end,
  },

  {
    "toggleterm.nvim",
    keys = {
      {"<A-h>", "<CMD>ToggleTerm direction=horizontal<CR>", desc = "Horizontal Term"},
    },
    after = function()
      require("toggleterm").setup({
        autochdir = true,
        open_mapping = [[<A-h>]],
        shell = "/run/current-system/sw/bin/nu",
      })
    end,
  },

  {
    "lualine.nvim",
    lazy = false,
    before = function()
      require("lualine").setup({
        tabline = {
          lualine_a = { 
            { 'buffers', symbols = { alternate_file = '' } } 
          },
        },
        options = {
          globalstatus = true,
          component_separators = { left = '', right = ''},
          section_separators = { left = '', right = ''},
          theme = {
            normal = {
              a = { bg = "#b4befe", fg = "#282828", gui = "bold", },
              b = { bg = "#313244", fg = "#b4befe", },
              c = { bg = "", fg = "#cdd6f4", },
            },
            insert = {
              a = { bg = "#89b4fa", fg = "#282828", gui = "bold", },
              b = { bg = "#313244", fg = "#89b4fa", },
              c = { bg = "", fg = "#cdd6f4", },
            },
            visual = {
              a = { bg = "#f38ba8", fg = "#282828", gui = "bold", },
              b = { bg = "#313244", fg = "#f38ba8", },
              c = { bg = "", fg = "#cdd6f4", },
            },
            replace = {
              a = { bg = "#fe8019", fg = "#282828", gui = "bold", },
              b = { bg = "#313244", fg = "#fe8019", },
              c = { bg = "", fg = "#cdd6f4", },
            },
          },
        },
      })
    end,
  },

  {
    "nvim-treesitter",
    lazy = false,
    after = function() 
      require('nvim-treesitter.configs').setup({
        sync_install = false,
        auto_install = false,
        highlight = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = false,
            node_decremental = "<A-CR>",
            node_incremental = "<CR>",
            -- scope_incremental = "grc",
          },
        },
        indent = {
          enable = true,
        },
      })
      -- don't fold by default .w.
      vim.opt.foldenable = false
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    end,
  },

  {
    "nvim-cmp",
    event = "InsertEnter",
    after = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      cmp.setup({
        formatting = {
          format = lspkind.cmp_format(),
        },
        snippet = {
          expand = function(args)
            vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },

        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },

        mapping = cmp.mapping.preset.insert({
          ['<C-k>'] = cmp.mapping.scroll_docs(-4),
          ['<C-j>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
          ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'}),
          ['<S-Tab>'] = cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'}),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp', priority = 1000 },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'path' },
          { name = 'treesitter' },
        }, {
          { name = 'buffer' },
        })
      })
    end,
  },
}

-- color scheme
vim.cmd.colorscheme "catppuccin"

-- keybinds
local map = vim.keymap.set
local defaults = { noremap = true, silent = true }

map('n', '<Tab>', '<CMD>bnext<CR>', default) -- Cycle next buffer
map('n', '<S-Tab>', '<CMD>bprevious<CR>', default) -- Cycle prev buffer
map('n', '<leader>x', '<CMD>bdelete<CR>', default) -- Delete current buffer
map('n', '<leader>X', '<CMD>bdelete!<CR>', default) -- Force delete current buffer
