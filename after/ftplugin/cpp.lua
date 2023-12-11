
require('lspconfig').clangd.setup{}

vim.keymap.set('n', '<leader>cf', ':%!clang-format<CR>', { silent = true , desc = "Format"})
