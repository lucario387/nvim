vim.api.nvim_create_user_command("ThemeEdit", "vsp " .. vim.fn.stdpath("config") .. "/lua/core/utils.lua", {})

vim.api.nvim_create_user_command("CompileTheme", function()
  require("plenary.reload").reload_module("core.utils")
  require("base46").load_all_highlights()
end, {})

vim.api.nvim_create_user_command("PackerSync", function(opts)
  -- vim.cmd("Lazy sync")
  require("plugins")
  require("packer").sync()
end, {
  bang = true,
  nargs = "*",
})
--
vim.api.nvim_create_user_command("PackerStatus", function(_)
  require("plugins")
  require("packer").status()
end, {
  bang = true,
})

