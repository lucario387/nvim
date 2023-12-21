local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local utils = require("config.ui.tabline.utils")
local list_contains = vim.list_contains or vim.tbl_contains

local disabled_buftypes = {
	"terminal",
	"prompt",
	-- "nofile",
}

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
	"dap-repl",
}

autocmd("TermOpen", {
	group = augroup("UnlistTerminal", { clear = true }),
	callback = function(args)
		vim.api.nvim_set_option_value("buflisted", false, { buf = args.buf})
	end,
})

autocmd({ "BufAdd", "BufEnter" }, {
	group = augroup("BufListAdd", { clear = true }),
	callback = function(args)
		local tabnr = vim.api.nvim_get_current_tabpage()
		if vim.t[tabnr].bufs == nil then
			vim.t[tabnr].bufs = { args.buf }
			return
		end
		if
			not utils.buf_is_valid(args.buf)
			or list_contains(disabled_buftypes, vim.api.nvim_get_option_value("buftype", { buf = args.buf }))
			or list_contains(disabled_filetypes, vim.api.nvim_get_option_value("filetype", { buf = args.buf }))
			or vim.api.nvim_get_option_value("bufhidden", { buf = args.buf }) == "wipe"
		then
			-- if not #vim.t[tabnr].bufs == 1 then
			utils.delete_buffer(args.buf)
			-- end
			return
		end

		local buflist = vim.t[tabnr].bufs

		-- check for duplicates
		if not list_contains(buflist, args.buf) and utils.buf_is_valid(args.buf) then
			-- and (args.event == "BufAdd" or utils.buf_is_valid(args.buf)) then
			table.insert(buflist, args.buf)
      utils.remove_buf_from_other_tab(args.buf, tabnr)
			vim.t[tabnr].bufs = buflist
		end
	end,
})

autocmd({ "BufDelete" }, {
	callback = function(args)
		if list_contains(vim.t.bufs, args.buf) then
			utils.delete_buffer(args.buf)
      utils.remove_buf_from_other_tab(args.buf, vim.api.nvim_get_current_tabpage())
		end
	end,
})

-- autocmd({ "BufNewFile", "BufRead", "TabEnter" }, {
--   group = augroup("TabLineLazyLoad", { clear = true }),
--   callback = function()
--     if #vim.fn.getbufinfo({ buflisted = true }) > 1 or #vim.api.nvim_list_tabpages() > 1 then
--       vim.opt.showtabline = 2
--       vim.opt.tabline = "%{%v:lua.require('config.ui').tabline()%}"
--       vim.api.nvim_del_augroup_by_name("TabLineLazyLoad")
--     end
--   end
-- })

-------------Buffer list and unlist on tab change

autocmd({ "TabNewEntered" }, {
	group = augroup("TabLineBufferList", { clear = true }),
	callback = function(args)
		-- local bufnr = vim.api.nvim_get_current_buf()
		vim.api.nvim_set_option_value("buflisted", true, {
      buf = args.buf
    })
		utils.add_buffer(args.buf)
	end,
})
autocmd("TabEnter", {
	group = augroup("TabLineBufferList", { clear = true }),
	callback = function()
		vim.api.nvim_command("silent! NvimTreeClose")
	end,
})
--
autocmd("TabLeave", {
	group = augroup("TabLineBufferUnList", { clear = true }),
	callback = function()
		vim.api.nvim_command("silent! NvimTreeClose")
	end,
})
