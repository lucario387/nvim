-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
--
-- if not vim.uv.fs_stat(lazypath) then
--   vim.system({
--     "git",
--     "clone",
--     "--filter=blob:none",
--     "https://github.com/folke/lazy.nvim.git",
--     -- "--branch=stable", -- latest stable release
--     lazypath,
--   },
--     {},
--     function(obj)
--       vim.fn.mkdir(vim.g.base46_cache, "p")
--     end
--   )
--   -- vim.fn.mkdir(vim.g.base46_cache, "p")
-- end

local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazy_path) then
  local obj = vim.system(
    {
    "git",
    "clone",
    "--depth", "1",
    "https://github.com/folke/lazy.nvim.git",
    lazy_path
    },
    {}
  ):wait()
  if obj.signal == 0 then
    vim.fn.mkdir(vim.g.base46_cache, "p")
  end
end

vim.opt.runtimepath:prepend(lazy_path)
