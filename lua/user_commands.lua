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

vim.api.nvim_create_autocmd("UIEnter", {
  -- once = true,
  callback = function()
    vim.cmd.clearjumps()
  end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
  group = vim.api.nvim_create_augroup("ReloadTheme", {}),
  pattern = vim.fs.normalize(vim.fn.stdpath("config") .. "/lua/core/utils.lua"),
  callback = function()
    require("plenary.reload").reload_module("core.utils")
    local config = require("core.utils").load_config()
    vim.g.nvchad_theme = config.ui.theme
    vim.g.transparency = config.ui.transparency
    require("plenary.reload").reload_module("base46")
    require("base46").load_all_highlights()
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen" --[["BufEnter"]] }, {
  callback = function()
    vim.cmd("startinsert")
    vim.wo.number = false
    vim.wo.relativenumber = false
    vim.wo.winfixheight = true
    vim.wo.winfixwidth = true
    vim.wo.signcolumn = "no"
    -- vim.wo.statuscolumn=""
  end,
  pattern = "term://*",
})

vim.api.nvim_create_autocmd({ "BufLeave" }, {
  callback = function()
    vim.cmd("stopinsert")
  end,
  pattern = "term://*",
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
  callback = function(opts)
    vim.treesitter.stop(opts.buf)
  end,
})


vim.api.nvim_create_autocmd("UIEnter", {
  callback = function(opts)
    vim.schedule(function()
      if vim.v.exiting ~= vim.NIL then
        return
      end
      -- buffer is a [No Name]
      local no_name = opts.file == "" and vim.bo[opts.buf].buftype == ""

      -- buffer is a directory
      local directory = vim.fn.isdirectory(opts.file) == 1

      if not no_name and not directory then
        return
      end
      if directory then
        vim.cmd.cd(opts.file)
        require("packer").loader("nvim-tree.lua")
        vim.cmd.NvimTreeToggle()
      end
    end)
  end,
})
