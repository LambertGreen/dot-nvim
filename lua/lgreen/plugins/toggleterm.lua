return
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup{
        size = 30
      }
    end,
    keys = {
      { '<leader>ot', '<cmd>ToggleTerm<CR>', desc = 'ToggleTerm' }
    },
  }
