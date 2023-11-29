return
{
  {
    "TimUntersberger/neogit",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    keys = {
      { '<leader>gg', '<cmd>Neogit<CR>', desc = 'Neogit' }
    },
    opts = { use_magit_keybindings = true }
  },
  {
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup()
    end
  },
}
