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

-- Map <leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-------------------------------------------------
-- Setup packages
-------------------------------------------------
require("lazy").setup({
	{
		"folke/tokyonight.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			-- load the colorscheme here
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"TimUntersberger/neogit",	
		dependencies = { { "nvim-lua/plenary.nvim" } },
		keys = { 
			{ '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' }
		},
		opts = {
			use_magit_keybindings = true
		}
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
		config = function()
			require('Comment').setup()
		end,
	},

}, opts)


