-- local M = {}
--
-- M.setup = function()
-- require("config.ui.tabline").setup()
local disabled_filetypes = {
	"NvimTree",
	"mason",
	"packer",
	"qf",
	"trouble",
	"alpha",
	"help",
	"terminal",
	"lspinfo",
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
require("config.ui.tabline.autocmds")
vim.opt.showtabline = 2
vim.opt.tabline = "%{%v:lua.require('config.ui.tabline').draw()%}"
vim.opt.statusline = "%{%v:lua.require('config.ui.statusline').draw()%}"
vim.api.nvim_create_autocmd({ "FileType" }, {
	callback = function(args)
		if
			vim.list_contains(disabled_filetypes, vim.bo[args.buf].filetype)
			or vim.list_contains(disabled_buftypes, vim.bo[args.buf].buftype)
		then
			return
		end
		vim.wo.winbar = "%{%v:lua.require('config.ui.winbar').draw()%}"
		vim.wo.statuscolumn = "%{%v:lua.require('config.ui.statuscolumn').draw()%}"
	end,
})
-- end
--
-- return M
