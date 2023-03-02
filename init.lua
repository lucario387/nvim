-- _G.lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/impatient.nvim")
-- print(vim.o.rtp)
vim.go.packpath = table.concat({
  -- vim.fn.stdpath("config"),
  vim.fn.stdpath("data") .. "/site",
  -- vim.env.VIMRUNTIME,
  -- vim.fn.stdpath("data") .. "/site/after",
  -- vim.fn.stdpath("config") .. "/after",
}, ",")
vim.o.rtp = table.concat({
  vim.fn.stdpath("config"),
  vim.fn.stdpath("data") .. "/site",
  vim.env.VIMRUNTIME,
  -- vim.fn.stdpath("data") .. "/site/after",
  vim.fn.stdpath("config") .. "/after",
}, ",")
pcall(require, "impatient")
require("impatient").enable_profile()
-- print(vim.o.rtp)

-- print(vim.o.rtp)

vim.g.base46_cache = vim.fn.stdpath("cache") .. "/nvchad/base46/"
vim.g.base46_custom_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/base46/lua/base46/integrations"

-- require("bootstrap")
require("options")
require("user_commands")

require("config.ui")
require("mappings").general()
-- require("mappings").telescope()
pcall(function()
  -- dofile(vim.g.base46_cache .. "bg")
  dofile(vim.g.base46_cache .. "defaults")
  dofile(vim.g.base46_cache .. "syntax")
  dofile(vim.g.base46_cache .. "devicons")
  -- dofile(vim.g.base46_cache .. "treesitter")
end)
-- require("plugins")
