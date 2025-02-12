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
  -- {
  --     "care.nvim",
  --     -- load care.nvim on InsertEnter
  --     event = "InsertEnter",
  -- },
}

-- color scheme
vim.cmd.colorscheme "catppuccin"
