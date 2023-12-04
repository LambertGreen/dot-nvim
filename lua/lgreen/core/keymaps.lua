-- Map <leader> to space
vim.g.mapleader      = " "
vim.g.maplocalleader = " "

-- Use useful Emacs/Readline bindings while in Insert mode
vim.keymap.set('i', '<C-a>', '<C-o>0', {})
vim.keymap.set('i', '<C-e>', '<C-o>$', {})

-- Buffer management
vim.keymap.set('n', '<leader>bs', ':w<CR>', { silent = true, desc = "Buffer save" })
vim.keymap.set('n', '<leader>bd', ':bd<CR>', { silent = true, desc = "Buffer delete" })
vim.keymap.set('n', '<leader>bp', ':bp<CR>', { silent = true, desc = "Buffer previous" })
vim.keymap.set('n', '<leader>bn', ':bn<CR>', { silent = true, desc = "Buffer next" })

vim.keymap.set('n', '<leader>bb', '<Cmd>Telescop buffers<CR>', { silent = true, desc = "Buffer List" })

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
vim.keymap.set('n', '<leader>cw', ':StripWhitespaceOnChangedLines<CR>', { silent = true , desc = "Strip whitespace on changed lines"})

-- Use LspAttach autocommand to only map the following keys
-- after the language server attaches to the current buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
  end,
})
