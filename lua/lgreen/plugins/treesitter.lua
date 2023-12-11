  return
  {
    {
      "nvim-treesitter/nvim-treesitter",
      event = { "BufReadPre", "BufNewFile" },
      build = ":TSUpdate",
      dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
        "windwp/nvim-ts-autotag",
      },
      config = function()

        -- We add specific compiler instructions to build `just` parser correctly
        require("nvim-treesitter.parsers").get_parser_configs().just = {
          install_info = {
            url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
            files = { "src/parser.c", "src/scanner.cc" },
            branch = "main",
            use_makefile = true, -- this may be necessary on MacOS (try if you see compiler errors)
          },
          maintainers = { "@IndianBoy42" },
        }

        -- import nvim-treesitter plugin
        local treesitter = require("nvim-treesitter.configs")

        -- configure treesitter
        treesitter.setup({ -- enable syntax highlighting
          highlight = {
            enable = true,
          },
          -- enable indentation
          indent = { enable = true },
          -- enable autotagging (w/ nvim-ts-autotag plugin)
          autotag = {
            enable = true,
          },
          -- ensure these language parsers are installed
          ensure_installed = {
            "bash",
            "cpp",
            "css",
            "dockerfile",
            "gitignore",
            "html",
            "javascript",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "query",
            "tsx",
            "typescript",
            "vim",
            "yaml",
          },
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = "<C-space>",
              node_incremental = "<C-space>",
              scope_incremental = false,
              node_decremental = "<bs>",
            },
          },
          -- enable nvim-ts-context-commentstring plugin for commenting tsx and jsx
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
        })
      end,
    },
    {
      "IndianBoy42/tree-sitter-just",
      dependencies = {
        "nvim-treesitter/nvim-treesitter",
      },
      config = function()
        require("tree-sitter-just").setup{}
      end,
    }
  }
