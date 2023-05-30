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

-- GUI
vim.opt.guifont  = "Iosevka NF:h11"
-- if vim.g.fv_loaded then
-- 	vim.cmd([[
-- 		if g:fvim_os == 'windows' || g:fvim_render_scale > 1.0
-- 		  set guifont=Iosevka\ NF:h14
-- 		else
-- 		  set guifont=Iosevka\ NF:h28
-- 		endif
--
-- 		" Ctrl-ScrollWheel for zooming in/out
-- 		nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
-- 		nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
-- 		nnoremap <A-CR> :FVimToggleFullScreen<CR>
-- 		]])
-- end

------------------------------------------------
-- Keymaps
-------------------------------------------------
-- Map <leader> to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set('n', '<leader>bs', ':w<CR>', { silent = true, desc = "Buffer save" })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { silent = true, desc = "Buffer delete" })
vim.keymap.set('n', '<leader>qq', ':q<CR>', { silent = true, desc = "Quit Vim" })
vim.keymap.set('n', '<leader>cw', ':%s/\\s\\+$//e<CR>', { noremap = true, silent = true })

------------------------------------------------
-- Setup packages
-------------------------------------------------
require("lazy").setup({
	{
		-- "folke/tokyonight.nvim",
		-- lazy = false, -- make sure we load this during startup if it is your main colorscheme
		-- priority = 1000, -- make sure to load this before all the other start plugins
		-- config = function() vim.cmd([[colorscheme tokyonight]]) end,
	},
	{
		"catppuccin/nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function() vim.cmd([[colorscheme catppuccin]]) end,
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
	{ 'lukoshkin/trailing-whitespace', },
	-- {
	-- 	'nvim-orgmode/orgmode',
	-- 	dependencies = { { "nvim-treesitter/nvim-treesitter" } },
	-- 	config = function() require('orgmode').setup() end,
	-- },
	{ "folke/neodev.nvim", },
}, opts)

