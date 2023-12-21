-- local M = {}
--
-- M.setup = function()
-- require("config.ui.tabline").setup()
local list_contains = vim.list_contains or vim.tbl_contains

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
  "sagadiagnostc",
  "sagadiagnostic",
	"TelescopePrompt",
	"TelescopeResults",
}

local disabled_buftypes = {
	"nofile",
	"help",
	"prompt",
  "terminal"
}

vim.t.bufs = vim.api.nvim_list_bufs()
vim.keymap.set("n", "<C-w>T", function()
  require("config.ui.tabline.utils").delete_buffer(vim.api.nvim_get_current_buf())
  vim.cmd("wincmd T")
end)
require("config.ui.tabline.autocmds")
vim.opt.showtabline = 2
vim.opt.tabline = "%{%v:lua.require('config.ui.tabline').draw()%}"
vim.opt.statusline = "%{%v:lua.require('config.ui.statusline').draw()%}"
vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function(args)
		if
			list_contains(disabled_filetypes, vim.bo[args.buf].filetype)
			or list_contains(disabled_buftypes, vim.bo[args.buf].buftype)
		then
			return
		end
		vim.wo.winbar = "%{%v:lua.require('config.ui.winbar').draw()%}"
		vim.wo.statuscolumn = "%{%v:lua.require('config.ui.statuscolumn').draw()%}"
    -- vim.wo.statuscolumn = "%C"
	end,
})
-- end
--
-- return M
