--================================================
-- Lambert's Neovim configuration
--================================================
-- luacheck: globals vim
--
-------------------------------------------------
-- Install Lazy package manager
-------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-------------------------------------------------
-- Vim Settings
-------------------------------------------------
vim.opt.title          = true
vim.opt.titlestring    = "%F - Nvim"
vim.opt.number         = true
vim.opt.relativenumber = true
vim.opt.termguicolors  = true
-- Enable mouse support in the terminal
vim.opt.mouse          = "a"
vim.opt.shiftwidth     = 4
vim.opt.softtabstop    = 4
vim.opt.tabstop        = 4

-- Trailing Whitespace config
-- We add 'dashboard' to the default list
vim.g.better_whitespace_filetypes_blacklist = {
  'diff',
  'git',
  'gitcommit',
  'unite',
  'qf',
  'help',
  'markdown',
  'fugitive',
  'dashboard'
}

-- GUI
local os_name          = jit.os
vim.opt.guifont = "Iosevka Nerd Font:h15"

------------------------------------------------
-- Keymaps
-------------------------------------------------
-- Map <leader> to space
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Use useful Emacs/Readline bindings while in Insert mode
vim.keymap.set('i', '<C-a>', '<C-o>0', {})
vim.keymap.set('i', '<C-e>', '<C-o>$', {})

-- Buffer management
vim.keymap.set('n', '<leader>bs', ':w<CR>', { silent = true, desc = "Buffer save" })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { silent = true, desc = "Buffer delete" })
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { silent = true, desc = "Buffer previous" })
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { silent = true, desc = "Buffer next" })

vim.keymap.set('n', '<leader>bb', '<Cmd>Telescop buffers<CR>', { silent = true, desc = "Buffer List" })

-- Window management
vim.keymap.set('n', '<leader>ws', ':split<CR>', { silent = true, desc = "Window split" })
vim.keymap.set('n', '<leader>wv', ':vsplit<CR>', { silent = true, desc = "Window vertical split" })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { silent = true, desc = "Move to left window" })
vim.keymap.set('n', '<leader>wh', '<C-w>h', { silent = true, desc = "Move to left window" })
vim.keymap.set('n', '<leader>wj', '<C-w>j', { silent = true, desc = "Move to bottom window" })
vim.keymap.set('n', '<leader>wk', '<C-w>k', { silent = true, desc = "Move to top window" })
vim.keymap.set('n', '<leader>wl', '<C-w>l', { silent = true, desc = "Move to right window" })
vim.keymap.set('n', '<leader>ww', '<C-w>w', { silent = true, desc = "Move to next window" })
vim.keymap.set('n', '<leader>wq', ':q<CR>', { silent = true, desc = "Move to next window" })

-- Terminal
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { silent = true, desc = "Move to next window" })

-- Quitting
vim.keymap.set('n', '<leader>qq', ':qall<CR>', { silent = true, desc = "Quit Vim" })

-- Code: remove trailing whitespace
vim.keymap.set('n', '<leader>cw', ':StripWhitespaceOnChangedLines<CR>', { silent = true , desc = "Strip whitespace on changed lines"})

-- Code: time command
function _G.time_command(cmd)
  local start_time = vim.loop.hrtime()
  vim.cmd(cmd)
  local elapsed_time = vim.loop.hrtime() - start_time
  print("Command " .. cmd .. " took " .. elapsed_time / 1e9 .. " seconds")
end

------------------------------------------------
-- Setup packages
-------------------------------------------------
require("lazy").setup({
  {
    "catppuccin/nvim",
    lazy = false,    -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd([[colorscheme catppuccin]])
      if vim.fn.has('mac') then
        local cmd = "defaults read -g AppleInterfaceStyle 2>/dev/null || echo Light"
        mode = vim.fn.system(cmd):gsub("\n", ""):lower()
        if mode == "dark" then
          vim.cmd('set background=dark')
        else
          vim.cmd('set background=light')
        end
      end
      -- vim.cmd('highlight Normal ctermbg=NONE guibg=NONE')
      -- vim.cmd('highlight NonText ctermbg=NONE guibg=NONE')
    end,
  },
  {
    "TimUntersberger/neogit",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' }
    },
    opts = { use_magit_keybindings = true }
  },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = true,
    keys = {
      { '<leader>ot', '<cmd>ToggleTerm<CR>', desc = 'ToggleTerm' }
    },
  },
  {
    "numToStr/Comment.nvim",
    config = function() require('Comment').setup() end,
  },
  { "gpanders/editorconfig.nvim", },
  { 'ntpeters/vim-better-whitespace', },
  {
    'nvim-orgmode/orgmode',
    dependencies = { { "nvim-treesitter/nvim-treesitter" } },
    ft = { 'org' },
    config = function()
      require('orgmode').setup()
      -- Load custom treesitter grammar for org filetype
      require('orgmode').setup_ts_grammar()

      require 'nvim-treesitter.install'.compilers = { "clang", "zig" }
      -- Treesitter configuration
      require('nvim-treesitter.configs').setup {
        -- If TS highlights are not enabled at all, or disabled via `disable` prop,
        -- highlighting will fallback to default Vim syntax highlighting
        highlight = {
          enable = true,
          -- Required for spellcheck, some LaTex highlights and
          -- code block highlights that do not have ts grammar
          additional_vim_regex_highlighting = { 'org' },
        },
        ensure_installed = { 'org' }, -- Or run :TSUpdate org
      }
      require('orgmode').setup({
        org_agenda_files = { '~/org/**/*' },
        org_default_notes_file = '~/org/refile.org',
      })
    end,
  },
  { "folke/neodev.nvim", },
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        "ahmedkhalf/project.nvim",
        -- opts = {},
        -- event = "VeryLazy",
        config = function(_, opts)
          require("project_nvim").setup(opts)
          require("telescope").load_extension("projects")
        end,
        keys = {
          { '<leader>ff',       ":Telescope find_files<CR>",   desc = 'Find Files' },
          { '<leader><leader>', ":Telescope find_files<CR>",   desc = 'Find Files' },
          { "<leader>pp",       "<Cmd>Telescope projects<CR>", desc = "Projects" },
        },
      },

    },
  },
  { 'nvim-tree/nvim-web-devicons' },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup()
      -- require('dashboard').setup {
      --     theme = 'doom',
      --     config = {
      --         -- header = {}, --your header
      --         center = {
      --             {
      --                 icon = ' ',
      --                 icon_hl = 'Title',
      --                 desc = 'Find File           ',
      --                 desc_hl = 'String',
      --                 key = 'b',
      --                 keymap = 'SPC f f',
      --                 key_hl = 'Number',
      --                 action = 'lua print(2)'
      --             },
      --             {
      --                 icon = ' ',
      --                 desc = 'Find Dotfiles',
      --                 key = 'f',
      --                 keymap = 'SPC f d',
      --                 action = 'lua print(3)'
      --             },
      --         },
      --     },
      -- }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  -- {
  --     'goolord/alpha-nvim',
  --     event = "VimEnter",
  --     dependencies = { 'nvim-tree/nvim-web-devicons' },
  --     config = function()
  --         require('alpha').setup(require("alpha.themes.dashboard").config)
  --     end,
  -- },
  -- {
  --     'goolord/alpha-nvim',
  --     event = "VimEnter",
  --     dependencies = { 'nvim-tree/nvim-web-devicons' },
  --     config = function()
  --         local startify = require("alpha.themes.startify")
  --         startify.section.top_buttons.val = {
  --             startify.button("e", "  New file", ":ene <BAR> startinsert <CR>"),
  --             startify.button("f", "  Find file", ":Telescope find_files <CR>"),
  --             startify.button("p", "  Find project", ":Telescope projects <CR>"),
  --             startify.button("t", "  Find text", ":Telescope live_grep <CR>"),
  --             startify.button("c", "  Configuration", ":e $MYVIMRC <CR>"),
  --             startify.button("z", "  Lazy", ":Lazy<CR>"),
  --             -- startify.button("q", "  Quit Neovim", ":qa<CR>"),
  --         }
  --         require('alpha').setup(startify.config)
  --     end,
  -- },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  -- Undo-Tree
  {
    "jiaoshijie/undotree",
    config       = function()
      require('undotree').setup()
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
}, opts)

-- Which-key registrations
local wk = require("which-key")
wk.register({
  ["<leader>b"] = { name = "+buffer" },
  ["<leader>f"] = { name = "+file" },
  ["<leader>p"] = { name = "+project" },
  ["<leader>c"] = { name = "+code" },
  ["<leader>q"] = { name = "+quit" },
  ["<leader>g"] = { name = "+git" },
  ["<leader>o"] = { name = "+open" },
  ["<leader>w"] = { name = "+window" },
})
