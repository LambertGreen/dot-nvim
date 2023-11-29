return
{
  'nvim-telescope/telescope.nvim',
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
}
