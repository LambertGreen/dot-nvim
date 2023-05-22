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
vim.opt.termguicolors = true
-- Enable mouse support in the terminal
vim.opt.mouse = "a"
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4

------------------------------------------------
-- Keymaps
-------------------------------------------------
-- Map <leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<leader>bs', ':w<CR>', { silent = true, desc = "Buffer save" })
vim.keymap.set('n', '<leader>bd', ':Bdelete<CR>', { silent = true, desc = "Buffer delete" })
vim.keymap.set('n', '<leader>cw', ':%s/\\s\\+$//e<CR>', { noremap = true, silent = true })

------------------------------------------------
-- Setup packages
-------------------------------------------------
require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function() vim.cmd([[colorscheme tokyonight]]) end,
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
	{ 'lukoshkin/trailing-whitespace', }
}, opts)

