local bufnr = vim.api.nvim_get_current_buf()
vim.keymap.set("n", "[d", function()
  vim.diagnostic.goto_prev({ float = true })
end, { desc = "goto prev diagnostic", buffer = bufnr })
vim.keymap.set("n", "]d", function() -- vim.diagnostic.goto_next()
  vim.diagnostic.goto_next({ float = true })
end, { desc = "goto next diagnostic", buffer = bufnr })

vim.bo.lispoptions="expr:1"
