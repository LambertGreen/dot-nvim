--================================================
-- Lambert's Neovim configuration
--================================================

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
vim.o.termguicolors = true
-- Enable mouse support in the terminal
vim.opt.mouse = "a"
-- Map <leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-------------------------------------------------
-- Setup packages
-------------------------------------------------
require("lazy").setup(plugins, opts)


