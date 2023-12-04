-- vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
--     pattern = "*.cpp",
--     callback = function()
--       require("lspconfig").clangd.setup{}
--     end,
-- })

vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
    pattern = "*.cpp",
    callback = function()
        print("Hello world")
    end
})
