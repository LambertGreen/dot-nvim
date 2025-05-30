--[[ Option Settings ]]

-- Title
vim.opt.title          = true
vim.opt.titlestring    = "%F - Nvim"

-- Line numbers
vim.opt.number         = true
vim.opt.relativenumber = true

-- Terminal
vim.opt.termguicolors  = true
vim.opt.mouse          = "a"

-- Editor
vim.opt.shiftwidth     = 4
vim.opt.softtabstop    = 4
vim.opt.tabstop        = 4
vim.opt.ignorecase     = true
vim.opt.smartcase      = true

-- Use system clipboard by default
-- We go this way because we Emacs+Evil on macOS
-- and the resultant experience is shared clipboards
vim.opt.clipboard = "unnamedplus"

-- Splits
vim.opt.splitbelow    = true
vim.opt.splitright    = true

-- Folding
vim.opt.foldlevel     = 99
-- vim.opt.foldnestmax   = 3

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
  'dashboard',
  'toggleterm',
}

-- GUI
local os_name          = jit.os
if os_name == "Windows" then
  vim.opt.guifont = "Iosevka NFM:h10"
else
  vim.opt.guifont = "Iosevka NFM:h13"
end
