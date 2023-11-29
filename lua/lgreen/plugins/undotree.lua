return
{
  "jiaoshijie/undotree",
  config = function()
    require('undotree').setup()
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
}
