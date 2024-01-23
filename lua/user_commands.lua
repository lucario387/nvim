vim.api.nvim_create_user_command("PackerSync", function(opts)
  -- vim.cmd("Lazy sync")
  require("lazy").sync()
end, {
  bang = true,
  nargs = "*",
})
vim.api.nvim_create_user_command("TSPlaygroundToggle", "InspectTree", {})
vim.api.nvim_create_user_command("GitHub", "Octo", {})
