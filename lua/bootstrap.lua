-- if not vim.loop.fs_stat(lazypath) then
--   vim.fn.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     "--branch=stable", -- latest stable release
--     lazypath,
--   })
--   vim.fn.mkdir(vim.g.base46_cache, "p")
-- end

local packer_path = vim.fn.stdpath("data") .. "/site/pack/packer/start"
if not vim.loop.fs_stat(packer_path) then
  vim.fn.system({
    "git",
    "clone",
    "--depth", "1",
    "https://github.com/wbthomason/packer.nvim",
    packer_path .. "/packer.nvim"
  })
  vim.fn.mkdir(vim.g.base46_cache, "p")
end

