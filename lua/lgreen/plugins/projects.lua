return
  {
    { "embear/vim-localvimrc" },
    { "ahmedkhalf/project.nvim",
      dependencies = {
        {"ahmedkhalf/project.nvim"}
      },
      opts = {
        -- Detection methods, order matters
        detection_methods = { "pattern" },
        -- Patterns to identify the root directory of a project
        patterns = { ".project", ".projectile", ".git", "_darcs", ".hg", ".bzr", ".svn" },
      },
      config = function(_, opts)
        require("project_nvim").setup(opts)
        require("telescope").load_extension("projects")
      end,
    }
  }
