
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
