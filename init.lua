-- _G.lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- vim.opt.rtp:append(vim.fn.stdpath("data") .. "/lazy/impatient.nvim")
vim.loader.enable()

local data_path = vim.fn.stdpath("data")
local config_path = vim.fn.stdpath("config")
vim.o.packpath = data_path .. "/site"
vim.opt.rtp = {
  config_path,
  data_path .. "/site",
  vim.env.VIMRUNTIME,
  -- data_path .. "/site/after",
  config_path .. "/after",
}


vim.g.base46_cache = data_path .. "/nvchad/base46/"

-- require("bootstrap")
require("options")
require("user_commands")
require("auto_commands")

require("mappings").general()
require("mappings").telescope()
