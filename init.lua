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

-- Use useful Emacs/Readline bindings while in Insert mode
vim.keymap.set('i', '<C-a>', '<C-o>0', { })
vim.keymap.set('i', '<C-e>', '<C-o>$', { })

-- Buffer management
vim.keymap.set('n', '<leader>bs', ':w<CR>', { silent = true, desc = "Buffer save" })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { silent = true, desc = "Buffer delete" })
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { silent = true, desc = "Buffer previous" })
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { silent = true, desc = "Buffer next" })

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
	{
		'nvim-telescope/telescope.nvim', tag = '0.1.1',
		dependencies = {
			{ 'nvim-lua/plenary.nvim' },
			{
				"ahmedkhalf/project.nvim",
				opts = {},
				event = "VeryLazy",
				config = function(_, opts)
					require("project_nvim").setup(opts)
					require("telescope").load_extension("projects")
				end,
				keys = {
					{ '<leader>ff', ":Telescope find_files<CR>", desc = 'Find Files'},
					{ '<leader><leader>', ":Telescope find_files<CR>", desc = 'Find Files'},
					{ "<leader>pp", "<Cmd>Telescope projects<CR>", desc = "Projects" },
				},
			},

		},
	},
	{
		"goolord/alpha-nvim",
		optional = true,
		opts = function(_, dashboard)
			local button = dashboard.button("p", " " .. " Projects", ":Telescope projects <CR>")
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
			table.insert(dashboard.section.buttons.val, 4, button)
		end,
	},
	{
		"echasnovski/mini.starter",
		optional = true,
		opts = function(_, opts)
			local items = {
				{
					name = "Projects",
					action = "Telescope projects",
					section = string.rep(" ", 22) .. "Telescope",
				},
			}
			vim.list_extend(opts.items, items)
		end,
	},
}, opts)

