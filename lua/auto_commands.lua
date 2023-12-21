local disabled_filetypes = {
  "NvimTree",
  "mason",
  "lazy",
  "qf",
  "trouble",
  "alpha",
  "help",
  "terminal",
  "lspinfo",
  "TelescopePrompt",
  "TelescopeResults",
  "noice",
}

local disabled_buftypes = {
  "noice",
  "nofile",
  "help",
  "prompt",
  "terminal",
}

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
    require("plenary.reload").reload_module("base46")
    local config = require("core.utils").load_config()
    vim.g.nvchad_theme = config.ui.theme
    vim.g.transparency = config.ui.transparency
    require("base46").load_all_highlights()
  end,
})

vim.api.nvim_create_autocmd({ "TermOpen" --[["BufEnter"]] }, {
  group = vim.api.nvim_create_augroup("TermConfig", {}),
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
  group = vim.api.nvim_create_augroup("TermConfig", {}),
  callback = function()
    vim.cmd("stopinsert")
  end,
  pattern = "term://*",
})

vim.api.nvim_create_autocmd("CmdwinEnter", {
  group = vim.api.nvim_create_augroup("CmdWin", {}),
  callback = function(opts)
    vim.treesitter.stop(opts.buf)
  end,
})


vim.api.nvim_create_autocmd("UIEnter", {
  callback = function(opts)
    local no_name = opts.file == "" and vim.bo[opts.buf].buftype == ""

    -- buffer is a directory
    local directory = vim.fn.isdirectory(opts.file) == 1

    if not no_name and not directory then
      return
    end
    if directory then
      vim.cmd.cd(opts.file)
      require("lazy.core.loader").load({"nvim-tree.lua"}, {})
      vim.cmd.NvimTreeToggle()
    end
  end,
})


local GitSignsLazyLoad = vim.api.nvim_create_augroup("GitSignsLazyLoad", {clear = true})

vim.api.nvim_create_autocmd("BufReadPre", {
  group = GitSignsLazyLoad,
  callback = function()
    local obj = vim.system(
      {
        "git",
        "rev-parse",
      },
      {
        cwd = vim.fn.expand("%:p:h"),
      }
    ):wait()
    if obj.signal == 0 then
      vim.api.nvim_del_augroup_by_id(GitSignsLazyLoad)

      require("lazy.core.loader").load({"gitsigns.nvim"}, {})
      return true
    end
  end,
})

-- ---@param padding_amount integer
-- ---@param margin_amount integer
-- local set_spacing = function(padding_amount, margin_amount)
--   -- locar command = string.format('kitty @ set-spacing padding=%d margin=%d', padding_amount, margin_amount)
--   vim.fn.system({
--     "kitty",
--     "@", "set-spacing",
--     "padding=" .. padding_amount,
--     "margin=" .. margin_amount,
--   })
-- end
--
-- set_spacing(0, 0)
--
-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   once = true,
--   callback = function()
--     set_spacing(20, 10)
--   end,
-- })
