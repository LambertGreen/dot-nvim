return
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { "ahmedkhalf/project.nvim"}
    },
    keys = {
      { '<leader>ff',       ":Telescope find_files<CR>",   desc = 'Find Files' },
      { '<leader><leader>', ":Telescope find_files<CR>",   desc = 'Find Files' },
      { "<leader>pp",       "<Cmd>Telescope projects<CR>", desc = "Projects" },
    },
  }
